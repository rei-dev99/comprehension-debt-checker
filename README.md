# 理解負債チェッカー

<img width="1200" height="1200" alt="Image" src="https://github.com/user-attachments/assets/c9c1702f-ece1-49d2-a688-6bc834e23b3f" />

## サービスURL

https://debt-lens.org/

## サービス概要
理解負債チェッカーとは、AI時代のプログラミング学習診断・改善アプリです。
AIに頼りすぎて、「理解したつもり」になっていないかを診断します。

## 開発背景
過去にAIに頼ってエンジニアになったが、現場に入ってからプログラムがなぜ動くのかわからない状態に苦しみ、先輩に教えてもらっても理解できず強い焦りを感じた経験があります。

- エラーが出たらAIにそのまま貼り付けて解決している
- 仮に動いたとしても「なぜ動いたか」説明できない
- チュートリアルが終わっても、自力で1からコードを書いて作ることができない

AIに依存したまま学習を進めると、自力で問題を解決する力が身につかず、AIでも解決できない問題に直面したときに行き詰まってしまいます。

また、理解できていない状態で先に進んでも基礎が抜けているため、 応用が効かず、学習内容が定着しなくなります。

決して、AIを使うことを否定したいわけではありません。

ましてやこれからの時代、AIを使うことが必須の時代になると考えています。
しかし、AIを使いこなすにも基礎知識が必要です。

「なぜこうやってコードを書くとシステムが動くのか」理解せず深掘りしないで進めると、応用や問題解決が難しくなり、どんどん苦しくなることが予想されます。

このサービスでは、AIを活用しながらも、自分の理解度やAIとの向き合い方を見直すきっかけを提供したいと考えています。

## 機能一覧
| 機能 | 概要 |
|:-----------|:------------|
| 認証 | Google・ゲスト・メールログイン |
| 診断 | 20問程度の質問から理解度を診断 |
| 診断結果 | カテゴリ別スコア・AI依存度・改善アドバイス |
| 履歴 | 過去の診断結果を保存・閲覧 |

診断では、

- AI活用習慣
- アルゴリズム基礎
- データベース理解
- Web技術理解

上記を複数の質問からスコア化し、ユーザーの理解傾向を分析できるようにしています。
また、診断結果をもとにAI依存度を算出し、学習改善のためのアドバイスを表示します。

## サービスの利用イメージ

| トップページ |
|:-----------:|
| サービス概要と診断開始ボタンを表示します。 |
| [![Image from Gyazo](https://i.gyazo.com/15948b73b70b3d3661178db6fdaa3e6e.png)](https://gyazo.com/15948b73b70b3d3661178db6fdaa3e6e) |

| ログインページ |
|:-----------:|
| メールアドレス・Google・ゲストログインから認証方法を選択できます。 |
| [![Image from Gyazo](https://i.gyazo.com/689a25f9f751bbe0f206ae014cffab3e.png)](https://gyazo.com/689a25f9f751bbe0f206ae014cffab3e) |

| マイページ |
|:-----------:|
| ログイン後に表示されるページです。診断開始や診断履歴の確認ができます。|
| [![Image from Gyazo](https://i.gyazo.com/84e21217149140d5063306f249838dba.png)](https://gyazo.com/84e21217149140d5063306f249838dba) |

| 質問 |
|:-----------:|
| 20問程度の質問に回答し、AI活用習慣や技術理解度を診断します。|
| [![Image from Gyazo](https://i.gyazo.com/e025ff704da9951f0bb7bf0d841b4943.gif)](https://gyazo.com/e025ff704da9951f0bb7bf0d841b4943) |

| 診断結果生成 |
|:-----------:|
| カテゴリごとのスコアやAI依存度を可視化し、学習改善のためのアドバイスを表示します。 |
| [![Image from Gyazo](https://i.gyazo.com/a28459a1a4612848be1223dd80710925.gif)](https://gyazo.com/a28459a1a4612848be1223dd80710925) |


| 診断結果一覧ページ |
|:-----------:|
| 過去の診断結果を一覧で確認し、自分の理解度の変化を振り返ることができます。 |
| [![Image from Gyazo](https://i.gyazo.com/fe24687ed589a3995d819fb56cd58a88.gif)](https://gyazo.com/fe24687ed589a3995d819fb56cd58a88) |

## 使用技術
| カテゴリ | 使用技術 |
|:-------|:-------|
|バックエンド|Ruby 4.0.1 ・ Ruby on Rails 8.1.3 (APIモード)|
|フロントエンド|Next.js 16.2.3 ・ React 19.2.4 ・ TypeScript 5.9.3|
|CSSフレームワーク|TailwindCSS|
|データベース|PostgreSQL 14.13|
|認証|JWT ・ Auth.js|
|CI/CD|GitHub Actions|
|開発環境|Docker|
|インフラ|AWS EC2 ・ RDS ・ ALB ・ Route53 ・ Amplify|
|その他|RSpec ・ RuboCop ・ Biome|

## ER図

```mermaid
erDiagram
    users ||--o{ results : ユーザーは複数の診断結果を参照できる
    users ||--|{ user_credentials : ユーザーは登録情報を保存する

    categories ||--o{ questions : "カテゴリーは複数の質問を持つ"
    questions ||--o{ choices : "質問は複数の選択肢を持つ"

    users {
        bigint id PK
        string status
        timestamp created_at
        timestamp deleted_at
    }

    user_credentials {
        bigint id PK
        bigint user_id FK
        string email
        string password_digest
        string provider
        string uid
        timestamp created_at
    }

    categories {
        bigint id PK
        string name
    }

    questions {
        bigint id PK
        bigint category_id FK
        string content
    }

    choices {
      bigint id PK
      bigint question_id FK
      string content
      integer score
    }

    results {
        bigint id PK
        bigint user_id FK
        integer ai_score
        integer algorithm_score
        integer db_score
        integer web_score
        integer dependency_score
        text advice
        timestamp created_at
    }
```

## インフラ構成図

<img width="667" height="766" alt="理解負債チェッカーインフラ構成図" src="https://github.com/user-attachments/assets/e7079a54-8b80-4087-9f5f-9d391c39aa73" />

## 開発状況

現在は MVP 段階として、認証機能・診断機能・診断履歴機能を中心に開発しています。

### 実装済み
- JWT認証
- Googleログイン
- ゲストログイン
- 簡易診断ロジック
- 診断履歴保存
- Rails API + Next.js 構成
- Docker環境整備
- RailsをAWS EC2へデプロイ
- Next.jsをAmplifyへデプロイ
- GitHub Actions による CIで、Rubocop / RSpec / Biome 実行

### 今後実装予定
- UI / UX 改善
- 診断結果一覧改善
- マイページ改善
- LPの充実
- テスト強化

## 技術的な工夫

### フロント・バックの分離
フロントとバックを分けて開発することによって、責務の分離を行いました。
これにより、バックではどのようなデータが必要になって配信すべきなのか明確になりました。

フロントエンドでは Next.js を採用し、APIから取得したデータを動的に表示することで、ユーザー体験を向上させるSPA構成を意識しています。

### 認証設計

Rails API と Next.js を分離した構成を採用し、JWT を用いた認証を実装しています。

また、

- 通常ログイン
- Googleログイン
- ゲストログイン

を共通の認証フローで扱えるよう設計しています。

### 保守性を意識した設計

- 診断ロジックは責務分離を意識し、スコア計算処理をサービスクラスへ切り出しています。
- usersテーブルにユーザー情報を集約するのではなく、OAuth認証やゲストログインなど認証方式が増えてもusersテーブルの責務が肥大化しないよう、認証情報をuser_credentialsへ分離しました。

### テスト

RSpec を用いて ModelSpec / RequestSpec を中心にテストを追加しています。
これにより期待した結果が返ってくるかどうか手動でなくシステムによって検証しています。

### CI（継続的インテグレーション）構築

GitHubへpushすると、自動でCIが実行されるようにしています。

- RuboCop
- RSpec
- Biome

これによりコードの品質向上やバグの早期発見に繋げて、品質を保ちながら、安全に変更を取り込めるようにしています。

### ESLintよりもBiome

コード品質を保つためにBiomeを採用しています。

Lint・Formatter をBiomeへ統一することで、
ESLint + Prettier 構成よりも高速なコード整形・静的解析を実現しています。
