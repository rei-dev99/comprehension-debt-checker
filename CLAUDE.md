# 理解負債チェッカー
AI時代のプログラミング学習診断・改善アプリ

# プロジェクト構造
- `back/`（Rails APIサーバー）、`front/`（Next.jsアプリ）のモノレポ構成
- backの詳細は、`back/CLAUDE.md`
- frontの詳細は、`front/CLAUDE.md`
- 設計・要件資料は `docs/`（下記「設計ドキュメント」参照）

# アーキテクチャ概要
- frontとbackを完全に分離し、frontはbackが返すJSON APIを叩くだけの構成
- 認証はfrontのAuth.js（Google / メール / ゲスト）がセッションを保持しつつ、backへのリクエストごとにRS256のJWTをfrontが署名して送る方式
  - 署名鍵（秘密鍵）: `front/keys/private.pem`
  - 検証鍵（公開鍵）: `back/config/keys/public.pem`（`back/app/controllers/concerns/authenticatable.rb`で検証）
  - issuer/audienceは `understanding-debt-checker-next` / `understanding-debt-checker-rails` で固定
  - backは初回アクセス時に`provider`+`uid`が一致する`UserCredential`が無ければ`User`と`UserCredential`を自動作成する（＝サインアップ専用エンドポイントを介さない自動プロビジョニング）

# 開発環境
`docker compose up`で全サービス起動（front/back/dbは常時起動済みのことが多く、その場合は`docker compose exec`だけで良い）

| サービス | ポート | 備考 |
|:-----------|:------------|:------------|
| front | 3000 | |
| back | 3001 | コンテナ内部は3000番、ホスト側で3001にマッピング |
| db | 5432 | PostgreSQL |

- バックエンドコマンド: `docker compose exec back <command>`（例: `docker compose exec back rails console`）
- フロントエンドコマンド: `docker compose exec front <command>`（例: `docker compose exec front npm install`）
- ⚠️ `docker compose exec back bash rails console`のように`bash`を挟むと、Ruby/Node本体をbashスクリプトとして実行しようとして構文エラーになる。`bash`は付けずコマンドを直接渡すこと。

# 設計ドキュメント（docs/）
- `docs/requirements.md`: サービスコンセプト・要件
- `docs/product.md`: 解決したい課題・潜在ニーズ
- `docs/design.md`: 設計方針
- `docs/api_design.md` / `docs/authentication.md` / `docs/questions_score_action.md`: API・認証フロー・診断ロジックの設計メモ
- `docs/swagger.yml`: OpenAPI形式のAPI仕様書。実装に合わせて更新済み（詳細は`back/CLAUDE.md`）。エンドポイントを追加・変更したときは一緒に更新すること

# コードコメントの方針
- 「コードと同じことを言うだけのコメント」「TODO や履歴メモ」などは不要。
- 意味のあるドキュメンテーションコメントは残す

# Gitルール
- コミットメッセージは `日本語` で記述
- フォーマット: `[Type]: [説明]`
- Type: add, fix, update, change, refactor, delete, test, chore, docsなど
- *mainブランチへの直push・直commit・mergeは絶対にしない*
- commit してよいのは、以下が成功した場合のみ
  - `docker compose exec back rubocop`
  - `docker compose exec back rspec`
  - `docker compose exec front npm run lint`（Biomeのフォーマット自動修正。エラー内容を確認したい場合は`npm run check`）

# その他
- 実装に合わせてテストコードは書くこと（back中心。frontは現状Biomeのlintのみで、Jest等の自動テストは未導入）
- 実装後は、必ずback（RuboCop, RSpec）とfront（Biome）のチェックを実施して通す
- UI/見た目を変更した場合は、コードの整合性チェックだけで終わらせず、実際にブラウザで表示を確認してから完了とする
