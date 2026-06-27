ai = Category.create!(name: "AI活用習慣")
algo = Category.create!(name: "アルゴリズム基礎")
db = Category.create!(name: "データベース")
web = Category.create!(name: "Web基礎")

# AIに関する質問
ai_q1 = Question.create!(content: "エラーが出た時、まず何をしますか？", category: ai)
ai_q2 = Question.create!(content: "AIの回答は、どのように扱いますか？", category: ai)
ai_q3 = Question.create!(content: "AIを使う前に、自分で確認することはありますか？", category: ai)
ai_q4 = Question.create!(content: "書いたコードを見て、意図を説明できますか？", category: ai)
ai_q5 = Question.create!(content: "AIを自分にとってどう使うものだと思いますか？", category: ai)

# アルゴリズムに関する質問
algo_q1 = Question.create!(content: "if文とfor文を組み合わせて処理の流れを考えられますか？", category: algo)
algo_q2 = Question.create!(content: "配列の要素を取り出して扱えますか？", category: algo)
algo_q3 = Question.create!(content: "関数を使って処理をまとめる意図を理解していますか？", category: algo)
algo_q4 = Question.create!(content: "コードの流れを順番に追って説明できますか？", category: algo)
algo_q5 = Question.create!(content: "簡単な処理を自分で組み立てるのは得意ですか？", category: algo)

# データベースに関する質問
db_q1 = Question.create!(content: "テーブル同士の関連付けについて説明できますか？", category: db)
db_q2 = Question.create!(content: "外部キーの役割を知っていますか？", category: db)
db_q3 = Question.create!(content: "どのテーブルにどのデータが入るか意識して設計できますか？", category: db)
db_q4 = Question.create!(content: "JOINが何のために使われるか分かりますか？", category: db)
db_q5 = Question.create!(content: "ORMを使う目的を説明できますか？", category: db)

# Web技術に関する質問
web_q1 = Question.create!(content: "GETとPOSTの違いを説明できますか？", category: web)
web_q2 = Question.create!(content: "HTTPのステータスコードを見て大まかな意味が分かりますか？", category: web)
web_q3 = Question.create!(content: "HTTP通信の基本的な流れを知っていますか？", category: web)
web_q4 = Question.create!(content: "CookieとSessionの違いについて説明できますか？", category: web)
web_q5 = Question.create!(content: "DOMやJSONの役割を理解していますか？", category: web)

# スコアは高ければ良い
Choice.create!([
  # AIに関する回答
  { content: "エラー文を読み、自分で原因を整理してから調べる", score: 3, question: ai_q1 },
  { content: "まずコードを見直してからAIを使う", score: 2, question: ai_q1 },
  { content: "すぐにAIに貼り付ける", score: 1, question: ai_q1 },

  { content: "回答をそのまま使わず、内容を確認する", score: 3, question: ai_q2 },
  { content: "必要な部分だけ参考にする", score: 2, question: ai_q2 },
  { content: "そのままコピペする", score: 1, question: ai_q2 },

  { content: "まず自分で考えてから使う", score: 3, question: ai_q3 },
  { content: "分からない時だけ使う", score: 2, question: ai_q3 },
  { content: "考える前に使うことが多い", score: 1, question: ai_q3 },

  { content: "意図や動きを説明できる", score: 3, question: ai_q4 },
  { content: "なんとなくは分かる", score: 2, question: ai_q4 },
  { content: "説明はできない", score: 1, question: ai_q4 },

  { content: "補助ツール", score: 3, question: ai_q5 },
  { content: "便利な相談相手", score: 2, question: ai_q5 },
  { content: "答えを全部任せる相手", score: 1, question: ai_q5 },

  # アルゴリズムに関する回答
  { content: "処理の流れを含めて説明できる", score: 3, question: algo_q1 },
  { content: "繰り返し処理ということは分かる", score: 2, question: algo_q1 },
  { content: "よく分からない", score: 1, question: algo_q1 },

  { content: "要素を取り出して扱える", score: 3, question: algo_q2 },
  { content: "要素番号を見ながら扱える", score: 2, question: algo_q2 },
  { content: "ほとんど分からない", score: 1, question: algo_q2 },

  { content: "処理をまとめる意味を説明できる", score: 3, question: algo_q3 },
  { content: "なんとなく使っている", score: 2, question: algo_q3 },
  { content: "使い分けが分からない", score: 1, question: algo_q3 },

  { content: "順番に追って説明できる", score: 3, question: algo_q4 },
  { content: "少しなら追える", score: 2, question: algo_q4 },
  { content: "難しい", score: 1, question: algo_q4 },

  { content: "自分で組み立てられる", score: 3, question: algo_q5 },
  { content: "簡単ならできる", score: 2, question: algo_q5 },
  { content: "まだ難しい", score: 1, question: algo_q5 },

  # データベースに関する回答
  { content: "関連付けの意味を説明できる", score: 3, question: db_q1 },
  { content: "なんとなく知っている", score: 2, question: db_q1 },
  { content: "分からない", score: 1, question: db_q1 },

  { content: "役割を説明できる", score: 3, question: db_q2 },
  { content: "名前は知っている", score: 2, question: db_q2 },
  { content: "分からない", score: 1, question: db_q2 },

  { content: "データの置き場所を意識できる", score: 3, question: db_q3 },
  { content: "少し意識している", score: 2, question: db_q3 },
  { content: "意識していない", score: 1, question: db_q3 },

  { content: "目的を説明できる", score: 3, question: db_q4 },
  { content: "使ったことはある", score: 2, question: db_q4 },
  { content: "分からない", score: 1, question: db_q4 },

  { content: "使う目的を説明できる", score: 3, question: db_q5 },
  { content: "なんとなく知っている", score: 2, question: db_q5 },
  { content: "分からない", score: 1, question: db_q5 },

  # Web技術に関する回答
  { content: "説明できる", score: 3, question: web_q1 },
  { content: "違いは何となく分かる", score: 2, question: web_q1 },
  { content: "分からない", score: 1, question: web_q1 },

  { content: "意味がだいたい分かる", score: 3, question: web_q2 },
  { content: "見たことはある", score: 2, question: web_q2 },
  { content: "分からない", score: 1, question: web_q2 },

  { content: "基本的な流れを知っている", score: 3, question: web_q3 },
  { content: "名前は知っている", score: 2, question: web_q3 },
  { content: "分からない", score: 1, question: web_q3 },

  { content: "違いを説明できる", score: 3, question: web_q4 },
  { content: "なんとなく知っている", score: 2, question: web_q4 },
  { content: "分からない", score: 1, question: web_q4 },

  { content: "役割を説明できる", score: 3, question: web_q5 },
  { content: "名前は知っている", score: 2, question: web_q5 },
  { content: "分からない", score: 1, question: web_q5 }
])
