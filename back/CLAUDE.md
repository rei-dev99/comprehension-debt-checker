# 理解負債チェッカー バックエンド
Rails API アプリケーション

## 技術スタック
- Ruby: 4.0.1
- Rails: 8.1.3（APIモード）
- DB: PostgreSQL 14.13
- 認証: JWT（RS256）
- Linter: RuboCop
- テスト: RSpec

## 開発コマンド（Docker経由）
すべてのコマンドはプロジェクトルートから `docker compose exec back <command>` で実行する。

⚠️ `docker compose exec back bash rails console` のように`bash`を挟むと、Rubyの実行ファイルをbashスクリプトとして読み込もうとして構文エラーになる。`bash`は付けず直接コマンドを渡すこと。

```
docker compose exec back rails console        # Railsコンソール
docker compose exec back rails db:migrate      # マイグレーション実行
docker compose exec back rails db:seed         # シードデータ投入
docker compose exec back rails routes          # ルーティング確認
```

## テスト
```
docker compose exec back rspec                  # 全テスト実行
docker compose exec back rspec spec/requests/    # リクエストスペックのみ
docker compose exec back rspec spec/models/      # モデルスペックのみ
docker compose exec back rspec <ファイルパス>     # 特定ファイル実行
```

リクエストスペックで認証をバイパスしたい場合は `spec/support/authentication_helpers.rb` の `stub_authentication(user)` を使う（`ApplicationController#authenticatable!` をスタブし、実際のJWT検証を通さず`@current_user`を差し込む）。

## lint
```
docker compose exec back rubocop      # チェック
docker compose exec back rubocop -A   # 自動修正
```

## 認証の仕組み
- frontがAuth.jsのセッション情報をもとに、リクエストごとにRS256のJWTを署名して`Authorization: Bearer <token>`ヘッダーで送ってくる
- backは`config/keys/public.pem`で検証する（`app/controllers/concerns/authenticatable.rb`の`Authenticatable`concern、`before_action :authenticatable!`）
- JWTのpayloadに含まれる`provider`+`uid`で`UserCredential`を検索し、なければ`User`と`UserCredential`をその場で自動作成する（Google/ゲスト/メールいずれも同じ経路）
- `provider == "email"`のときのみ`UserCredential`に`email`・`password`のバリデーションが効く（`has_secure_password validations: false`でOAuth/ゲストはパスワード不要にしている）

## ディレクトリ構造
```
app/
├── controllers/
│   ├── api/v1/            # APIエンドポイント（authentication, categories, category_summaries,
│   │                       #   choices, guest_sessions, health, questions, results, users）
│   └── concerns/
│       ├── authenticatable.rb  # JWT検証・ユーザー自動作成
│       └── pagination.rb       # 一覧APIのページネーションレスポンス整形
└── models/
    ├── category.rb / category_summary.rb / choice.rb / question.rb
    ├── result.rb                     # 診断結果本体（カテゴリ別スコア・依存度スコア・advicesを保持）
    ├── user.rb / user_credential.rb  # 認証情報はuser_credentialsに分離（usersテーブルを肥大化させない設計）
    └── diagnosis/                    # 診断ロジック本体。単一責任の原則に沿ってservicesから独立させた名前空間
        ├── scoring/
        │   ├── category_score.rb     # カテゴリ別スコア算出
        │   └── dependency_score.rb   # AI依存度スコア算出
        └── advice/
            └── generate_advice.rb    # スコアに応じたアドバイス生成

spec/
├── requests/api/v1/   # APIリクエストスペック（エンドポイント単位）
├── models/            # モデル・診断ロジックのユニットスペック
├── support/           # stub_authenticationなどのテストヘルパー
└── factories/         # FactoryBot定義
```

## 主要APIエンドポイント（`config/routes.rb`）
| メソッド | パス | 用途 |
|:---|:---|:---|
| GET | `/api/v1/health` | ヘルスチェック |
| GET | `/api/v1/categories` | カテゴリ一覧 |
| GET | `/api/v1/category_summaries` | カテゴリ別の総評マスタ |
| GET | `/api/v1/questions` | 質問一覧（選択肢込み） |
| GET | `/api/v1/choices` | 選択肢一覧 |
| GET | `/api/v1/results` | 診断結果一覧（ページネーション付き） |
| GET | `/api/v1/results/:id` | 診断結果詳細 |
| POST | `/api/v1/results` | 診断結果の作成（回答を送信しスコア・アドバイスを算出） |
| GET | `/api/v1/users` | ⚠️ ルーティングのみ存在し`index`アクション未実装（404を返す） |
| POST | `/api/v1/login` | Google等プロバイダログイン（要Bearer、body無し。JWTのprovider/uidでUser/UserCredentialを自動作成） |
| POST | `/api/v1/login_email` | メールログイン |
| POST | `/api/v1/signup_email` | メール新規登録 |
| POST | `/api/v1/guest_login` | ゲストログイン |

詳細なリクエスト/レスポンス仕様は`docs/swagger.yml`を参照（実装に合わせて更新済み。エンドポイントを追加・変更したらこのファイルも一緒に更新すること）。

## 主要モデルのバリデーション上の注意
- `Choice#score`は`1..3`の範囲のみ許可
- `Result`の`ai_score` / `algorithm_score` / `db_score` / `web_score`は`0..15`、`dependency_score`は`0..100`の範囲でバリデーション
- `User#status`は`active` / `deleted`のみ許可
