# 理解負債チェッカー フロントエンド
Next.js アプリケーション（App Router）

このNext.jsのバージョンは学習データ上の一般的なNext.jsと規約が異なる箇所がある（`AGENTS.md`参照）。実装前に`node_modules/next/dist/docs/`該当ページを確認すること。代表例が下記の`proxy.ts`。

## 技術スタック
- Next.js: 16.2.3
- React: 19.2.4
- TypeScript: 5.9.3
- CSSフレームワーク: TailwindCSS
- 認証: Auth.js（NextAuth） + 自前のJWT(RS256)ブリッジ
- Linter: Biome

すべてのパッケージ管理操作には`npm`を使用する

## 開発コマンド（Docker経由）
すべてのコマンドはプロジェクトルートから `docker compose exec front <command>` で実行する。

⚠️ `docker compose exec front bash npm install` のように`bash`を挟むと、npm本体をbashスクリプトとして読み込もうとして構文エラーになる。`bash`は付けず直接コマンドを渡すこと。

```
docker compose exec front npm install   # 依存関係をインストール
docker compose exec front npm run dev   # 開発サーバー起動（通常はdocker compose upで起動済み）
```

## lint
```
docker compose exec front npm run lint   # Biomeによるフォーマット自動修正
docker compose exec front npm run check  # フォーマット・lintエラーの確認（書き換えなし）
```

⚠️ ローカル（macOS arm64ホスト）で直接 `npx @biomejs/biome` を実行すると `Cannot find module '@biomejs/cli-darwin-arm64/biome'` で失敗することがある。lint/checkは必ずDocker経由で実行する。

現状、frontにJest/Vitest等の自動テストは導入されていない。品質担保はBiomeのlintと、UI変更時のブラウザでの目視確認に依っている。

## 認証・APIアクセスの仕組み
- `auth.ts`: Auth.jsの設定。Google OAuthと、Credentials provider（`loginType`で通常ログイン/ゲストログインを分岐）。セッションはJWT戦略（有効期限3日）
- `proxy.ts`（プロジェクトルート直下。**`app/`の中ではなくfrontのルート**に置く必要がある。誤って`app/`配下に置くと読み込まれず、保護ルートが素通りになる）
  - 未認証で`/question`・`/results`・`/mypage`にアクセス→`/login`へリダイレクト
  - 認証済みで`/login`・`/signup`にアクセス→`/mypage`へリダイレクト
- `app/lib/requireAuth.ts` / `requireSession.ts`: サーバーコンポーネント・Server Actionから使う認証ガード。`"use client"`ページ（`app/question/page.tsx`、`app/results/page.tsx`）は`useEffect`内から呼んでいるため、ハイドレーション前は一瞬保護前のHTMLが返る。プロキシによる保護と合わせて多層防御している
- `app/lib/createBackendJwt.ts` / `getBackendJwt.ts`: Auth.jsのセッション（email/provider/uid）を材料に、RS256の短命JWT（有効期限1時間）をその場で署名してbackへのAPIリクエストに付与する
  - 秘密鍵はローカルでは`front/keys/private.pem`、本番では環境変数`JWT_PRIVATE_KEY`から読む
  - issuer/audienceは`understanding-debt-checker-next` / `understanding-debt-checker-rails`固定（back側の検証と対になっている。`back/CLAUDE.md`参照）

## 必要な環境変数（`.env`。値はコミットしない）
- `AUTH_SECRET` / `AUTH_URL`: Auth.js用
- `AUTH_GOOGLE_ID` / `AUTH_GOOGLE_SECRET`: Google OAuth
- `NEXT_PUBLIC_API_BASE_URL`: backの`/api/v1`ベースURL
- `JWT_PRIVATE_KEY`: 本番でbackへのJWT署名に使う秘密鍵（ローカルは`keys/private.pem`を使うため不要）

## ディレクトリ構造
```
app/
├── page.tsx                 # トップページ（LP）
├── layout.tsx                # 全ページ共通レイアウト（Header/Footerをここでマウント）
├── login/, signup/            # 認証ページ
├── mypage/                    # マイページ（サーバーコンポーネントでrequireAuth）
├── question/                  # 診断質問ページ（クライアントコンポーネント）
├── results/, results/[id]/    # 診断結果一覧・詳細（クライアントコンポーネント）
├── api/auth/[...nextauth]/    # Auth.jsのルートハンドラ
└── lib/                       # API fetchラッパー・認証ガード・JWT生成（上記参照）

actions/        # Server Actions（handleLogin, handleGuestLogin, handleSignup, handleLogout, handleGoogleLogin）
components/
├── header.tsx, footer.tsx     # 共通ヘッダー・フッター
├── atoms/                     # Login/Logoutボタンなど小さな部品
└── forms/                     # GuestForm, LoginForm, SignupForm

types/          # category / question / result の型定義、next-authの型拡張
proxy.ts        # ルート保護（上記参照。app/の外、frontのルート直下）
auth.ts         # Auth.js設定
```
