ai = Category.find_or_create_by!(name: "AI活用習慣")
algo = Category.find_or_create_by!(name: "アルゴリズム基礎")
db = Category.find_or_create_by!(name: "データベース")
web = Category.find_or_create_by!(name: "Web基礎")

ai_q1 = Question.find_or_create_by!(content: "エラーが出た時、まず何をしますか？", category: ai)
ai_q2 = Question.find_or_create_by!(content: "AIの回答は、どのように扱いますか？", category: ai)
ai_q3 = Question.find_or_create_by!(content: "AIを使う前に、自分で確認することはありますか？", category: ai)
ai_q4 = Question.find_or_create_by!(content: "書いたコードを見て、意図を説明できますか？", category: ai)
ai_q5 = Question.find_or_create_by!(content: "AIを自分にとってどう使うものだと思いますか？", category: ai)

algo_q1 = Question.find_or_create_by!(content: "if文とfor文を組み合わせて処理の流れを考えられますか？", category: algo)
algo_q2 = Question.find_or_create_by!(content: "配列の要素を取り出して扱えますか？", category: algo)
algo_q3 = Question.find_or_create_by!(content: "関数を使って処理をまとめる意図を理解していますか？", category: algo)
algo_q4 = Question.find_or_create_by!(content: "コードの流れを順番に追って説明できますか？", category: algo)
algo_q5 = Question.find_or_create_by!(content: "簡単な処理を自分で組み立てるのは得意ですか？", category: algo)

db_q1 = Question.find_or_create_by!(content: "テーブル同士の関連付けについて説明できますか？", category: db)
db_q2 = Question.find_or_create_by!(content: "外部キーの役割を知っていますか？", category: db)
db_q3 = Question.find_or_create_by!(content: "どのテーブルにどのデータが入るか意識して設計できますか？", category: db)
db_q4 = Question.find_or_create_by!(content: "JOINが何のために使われるか分かりますか？", category: db)
db_q5 = Question.find_or_create_by!(content: "ORMを使う目的を説明できますか？", category: db)

web_q1 = Question.find_or_create_by!(content: "GETとPOSTの違いを説明できますか？", category: web)
web_q2 = Question.find_or_create_by!(content: "HTTPのステータスコードを見て大まかな意味が分かりますか？", category: web)
web_q3 = Question.find_or_create_by!(content: "HTTP通信の基本的な流れを知っていますか？", category: web)
web_q4 = Question.find_or_create_by!(content: "CookieとSessionの違いについて説明できますか？", category: web)
web_q5 = Question.find_or_create_by!(content: "DOMやJSONの役割を理解していますか？", category: web)

category_summaries = [
  { category: ai, min_score: 12, max_score: 15, summary: "AIを適切に活用できています。今のようにAIを参考にしつつ、自分で考える時間も続けることで、理解をさらに深められます。" },
  { category: ai, min_score: 9, max_score: 11, summary: "AIは活用できていますが、自分で考える時間も意識するとさらに理解が深まります。AIの回答をそのまま使うのではなく、「なぜそうなるのか」を確認する習慣を続けてみましょう。" },
  { category: ai, min_score: 5, max_score: 8, summary: "AIに頼る場面がやや多い傾向があります。まずは5分だけ自分で考えてからAIを使う習慣を取り入れると、自力で解決できる力が身につきます。" },
  { category: algo, min_score: 12, max_score: 15, summary: "基本的なアルゴリズムを理解できています。今後は配列やハッシュ、探索や並び替えなどを実際に実装しながら理解を深めていきましょう。" },
  { category: algo, min_score: 9, max_score: 11, summary: "基本的な考え方は身についています。簡単な問題を自分で考えて解く機会を増やすと、さらに理解が深まります。" },
  { category: algo, min_score: 5, max_score: 8, summary: "アルゴリズムの理解はこれから伸ばせる段階です。まずはif文・繰り返し処理・配列など、基本的な処理を自分で書く練習から始めましょう。" },
  { category: db, min_score: 12, max_score: 15, summary: "データベースの基礎は身についています。テーブル設計やリレーションを意識しながら開発を続けると、さらに実践力が身につきます。" },
  { category: db, min_score: 9, max_score: 11, summary: "基本的な知識は身についています。実際にSQLを書いたり、データの流れを意識しながら学ぶと理解がより深まります。" },
  { category: db, min_score: 5, max_score: 8, summary: "データベースの基礎を復習すると理解が深まりそうです。まずはテーブル・主キー・外部キーの役割を整理するところから始めてみましょう。" },
  { category: web, min_score: 12, max_score: 15, summary: "Webの基礎はしっかり身についています。HTTP通信やAPIの流れを意識しながら実装すると、より実践的な力が身につきます。" },
  { category: web, min_score: 9, max_score: 11, summary: "基本的なWebの知識は身についています。リクエストからレスポンスまでの流れを意識すると、さらに理解が深まります。" },
  { category: web, min_score: 5, max_score: 8, summary: "Webの基礎を復習すると理解が深まりそうです。まずはHTTP・URL・Cookie・Session・Webの仕組みなど、基本的な仕組みから学び直してみましょう。" }
]

category_summaries.each do |attrs|
  CategorySummary.find_or_create_by!(
    category: attrs[:category],
    min_score: attrs[:min_score],
    max_score: attrs[:max_score]
  ) do |summary|
    summary.summary = attrs[:summary]
  end
end

# スコアは高ければ良い
choices = [
  # AIに関する回答
  { content: "エラー文を読み、自分で原因を整理してから調べる", score: 3, question: ai_q1, feedback:  "しっかりと自分で考える習慣が身についています。この調子で、原因を整理してからAIを活用する姿勢を続けていきましょう。" },
  { content: "まずコードを見直してからAIを使う", score: 2, question: ai_q1, feedback: "いい傾向です。コードを見直したらエラーも確認してみましょう。" },
  { content: "すぐにAIに貼り付ける", score: 1, question: ai_q1, feedback: "最初は、5分とか数分でいいので自分で考えてみましょう。" },

  { content: "回答をそのまま使わず、内容を確認する", score: 3, question: ai_q2, feedback: "AIを参考として適切に活用できています。これからも内容を理解しながら使う習慣を続けましょう。" },
  { content: "必要な部分だけ参考にする", score: 2, question: ai_q2, feedback: "この調子でAIの回答を必要な箇所を参考にしながら活用していきましょう" },
  { content: "そのままコピペする", score: 1, question: ai_q2, feedback: "コピペからとりあえずでもAIの回答を読んでいきましょう。内容を理解してから使うことを意識すると良さそうです。" },

  { content: "まず自分で考えてから使う", score: 3, question: ai_q3, feedback: "自分で考えてからAIを活用できています。この姿勢を続けることで問題解決力も伸ばしていけます。" },
  { content: "分からない時だけ使う", score: 2, question: ai_q3, feedback: "分からないときにAIを活用できています。まず自分で考える習慣も続けることで、理解がさらに深まります。" },
  { content: "考える前に使うことが多い", score: 1, question: ai_q3, feedback: "最初の一歩として、AIを使う前に5分程度でいいので自力で問題に対するアプローチを考えてみましょう。" },

  { content: "意図や動きを説明できる", score: 3, question: ai_q4, feedback: "コードの意図を理解しながら実装できています。この調子で他人のコードも読み解く力を伸ばしていきましょう。" },
  { content: "なんとなくは分かる", score: 2, question: ai_q4, feedback: "その調子です。実際のコードの出力を確認するなどして、なんとなくわかる状態から意図を理解できる状態を目指していきましょう。" },
  { content: "説明はできない", score: 1, question: ai_q4, feedback: "おすすめなのは、コードを一行ずつ読みながら「何をしているか」を自分の言葉で説明する練習をすることです。" },

  { content: "補助ツール", score: 3, question: ai_q5, feedback: "AIを補助ツールとして適切に活用できています。この姿勢を続けていきましょう。" },
  { content: "便利な相談相手", score: 2, question: ai_q5, feedback: "AIを相談相手として活用できています。最終的な判断は自分で行う意識を持つとさらに良くなります。" },
  { content: "答えを全部任せる相手", score: 1, question: ai_q5, feedback: "AIを答えを教えてもらう相手ではなく、学習を支える補助ツールとして考えてみましょう。" },

  # アルゴリズムに関する回答
  { content: "処理の流れを含めて説明できる", score: 3, question: algo_q1, feedback: "処理の流れを理解できています。" },
  { content: "繰り返し処理ということは分かる", score: 2, question: algo_q1, feedback: "まずは一歩いい感じです。次は条件による処理の理解も深めていきましょう。" },
  { content: "よく分からない", score: 1, question: algo_q1, feedback: "if文と繰り返し処理を別々に書いて処理を理解し、そこからif文と繰り返しを組み合わせる練習をしてみましょう。" },

  { content: "要素を取り出して扱える", score: 3, question: algo_q2, feedback: "配列の基本を理解できています。" },
  { content: "要素番号を見ながら扱える", score: 2, question: algo_q2, feedback: "いい感じです。簡単な配列操作の問題を解いていくと理解が深まります。" },
  { content: "ほとんど分からない", score: 1, question: algo_q2, feedback: "最初のスタートとして、配列から1つの要素を取り出したり、繰り返し処理で表示する練習をしてみましょう。" },

  { content: "処理をまとめる意味を説明できる", score: 3, question: algo_q3, feedback: "関数の使い方は問題ありません。より関数の使い方を極めていきましょう。" },
  { content: "なんとなく使っている", score: 2, question: algo_q3, feedback: "関数を使う理由や、同じ処理をまとめるメリットを意識しながら書いてみましょう。" },
  { content: "使い分けが分からない", score: 1, question: algo_q3, feedback: "関数を基礎からやり直してみましょう。いろんな関数の処理を作って動かしてみましょう。" },

  { content: "順番に追って説明できる", score: 3, question: algo_q4, feedback: "コードの流れを順番に追えているので、その調子で少し長いコードにも挑戦してみましょう。" },
  { content: "少しなら追える", score: 2, question: algo_q4, feedback: "コードでうまく読めなかったり理解できないところがあれば、基礎に戻ってみましょう。" },
  { content: "難しい", score: 1, question: algo_q4, feedback: "不明点を言語化して、足りない知識があれば基礎からやり直してみましょう。" },

  { content: "自分で組み立てられる", score: 3, question: algo_q5, feedback: "いい感じです。複雑な処理も組み立てられるようにアルゴリズム学習を続けていきましょう。" },
  { content: "簡単ならできる", score: 2, question: algo_q5, feedback: "簡単な処理を組み立てつつ、時には新しいメソッドやアルゴリズムなども学びつつ、活用してみましょう。" },
  { content: "まだ難しい", score: 1, question: algo_q5, feedback: "少しずつ複数の処理を組み合わせた問題にも挑戦してみましょう。" },

  # データベースに関する回答
  { content: "関連付けの意味を説明できる", score: 3, question: db_q1, feedback: "関連付けの考え方は理解できています。この調子で設計にも活かしていきましょう。" },
  { content: "なんとなく知っている", score: 2, question: db_q1, feedback: "関連付けは大事な概念なので、「なんとなく」から「理解した！」状態に持っていきましょう。" },
  { content: "分からない", score: 1, question: db_q1, feedback: "関連付けの理解はこれから伸ばせます。まずは1対多・多対多の関係を実際にテーブルを作りながら確認してみましょう。" },

  { content: "役割を説明できる", score: 3, question: db_q2, feedback: "外部キーの役割を理解できています。実際のアプリでもどのテーブルを結び付けているか意識するとさらに理解が深まります。" },
  { content: "名前は知っている", score: 2, question: db_q2, feedback: "名前を知っているのはグッドです。次は外部キーを実際に設定してみてどう使われるのか理解してみましょう。" },
  { content: "分からない", score: 1, question: db_q2, feedback: "テーブルについて基礎からやり直してみて、実際に手を動かして作ってみましょう。" },

  { content: "データの置き場所を意識できる", score: 3, question: db_q3, feedback: "データを意識して設計できています。データの型とかデータのつながりなど、さらに良い設計を目指していきましょう。" },
  { content: "少し意識している", score: 2, question: db_q3, feedback: "いい感じです。どんなデータだといいのか、データを格納するテーブルなど慣れてきたらさらに意識して設計していきましょう。" },
  { content: "意識していない", score: 1, question: db_q3, feedback: "データの置き場所を考える力はこれから身につけていけます。テーブルを作る前に「何を保存したいか」を整理する習慣をつけてみましょう。" },

  { content: "目的を説明できる", score: 3, question: db_q4, feedback: "JOINの役割は理解できています。INNER JOINやLEFT JOINの違いも確認するとさらに実践で役立ちます。" },
  { content: "使ったことはある", score: 2, question: db_q4, feedback: "JOIN使ったことがあるなら、実際にSQLで試してみてどんなデータが取り出されるのか中身を確認しながら理解していきましょう。" },
  { content: "分からない", score: 1, question: db_q4, feedback: "基本のSQLから理解していきましょう。慣れてきたらJOINを使ってテーブルの結合をやってみましょう。" },

  { content: "使う目的を説明できる", score: 3, question: db_q5, feedback: "ORMの役割は理解できています。生成されるSQLも確認するとさらに理解が深まります。" },
  { content: "なんとなく知っている", score: 2, question: db_q5, feedback: "まずはなんとなくでも大丈夫。実際にORMを何かしら使ってみてデータを確認するなどして理解していきましょう。" },
  { content: "分からない", score: 1, question: db_q5, feedback: "基本的なSQLから理解しましょう。ORMも少しずつ触って、データを確認したり、どんなSQLで実行されているのか身につけていきましょう。" },

  # Web技術に関する回答
  { content: "説明できる", score: 3, question: web_q1, feedback: "GETとPOSTの役割は理解できています。次はPUTやDELETEも合わせて覚えると理解が広がります。" },
  { content: "違いは何となく分かる", score: 2, question: web_q1, feedback: "他のHTTPメソッドについても調べてみましょう。" },
  { content: "分からない", score: 1, question: web_q1, feedback: "HTTPメソッドについて調べてみて、どんなものがあるのか確認してみましょう。" },

  { content: "意味がだいたい分かる", score: 3, question: web_q2, feedback: "代表的なステータスコードの番号と処理結果を理解していきましょう。" },
  { content: "見たことはある", score: 2, question: web_q2, feedback: "よく見かける代表的なステータスコードが何を表すのか調べてみましょう。" },
  { content: "分からない", score: 1, question: web_q2, feedback: "最初は、書籍とかネットで「HTTP ステータスコードとは？」から調べることから始めましょう。" },

  { content: "基本的な流れを知っている", score: 3, question: web_q3, feedback: "HTTP通信について良さそうです。HTTPの概念から深いところまで調べて活用していきましょう。" },
  { content: "名前は知っている", score: 2, question: web_q3, feedback: "HTTPリクエストとHTTPレスポンスについて調べて理解していきましょう。" },
  { content: "分からない", score: 1, question: web_q3, feedback: "書籍とかネットで「HTTP 通信とは？」から調べてみましょう。" },

  { content: "違いを説明できる", score: 3, question: web_q4, feedback: "CookieとSessionの違いについて大丈夫そうです。実際に処理をやってみることで理解が深まります。" },
  { content: "なんとなく知っている", score: 2, question: web_q4, feedback: "なんとなくでも大丈夫。最初は混乱しやすい分野なので少しずつ理解していきましょう。" },
  { content: "分からない", score: 1, question: web_q4, feedback: "CookieとSessionについて調べてみましょう。" },

  { content: "役割を説明できる", score: 3, question: web_q5, feedback: "DOMやJSONの役割は理解できています。簡単なAPI通信などを作るとさらに理解が深まります。" },
  { content: "名前は知っている", score: 2, question: web_q5, feedback: "実際にDOMやJSONを操作してみたり、簡単なAPI通信を作ることにも挑戦すると理解が深まります。" },
  { content: "分からない", score: 1, question: web_q5, feedback: "JSONを実際に表示してみたり、DOMを操作する簡単なサンプルを動かしてみると理解しやすくなります。" }
]

choices.each do |attrs|
  Choice.find_or_create_by!(
    question: attrs[:question],
    content: attrs[:content]
  ) do |choice|
    choice.score = attrs[:score]
    choice.feedback = attrs[:feedback]
  end
end
