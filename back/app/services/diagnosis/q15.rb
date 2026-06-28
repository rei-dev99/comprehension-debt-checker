module Diagnosis
    class Q15
        # 質問内容: ORMを使う目的を説明できますか？
        # 回答1: 使う目的を説明できる
        # 回答2: なんとなく知っている
        # 回答3: 分からない

        def initialize(score)
            @score = score
        end

        def call
            case @score
            when 1 then
                "基本的なSQLから理解しましょう。ORMも少しずつ触って、データを確認したり、どんなSQLで実行されているのか身につけていきましょう。"
            when 2 then
                "まずはなんとなくでも大丈夫。実際にORMを何かしら使ってみてデータを確認するなどして理解していきましょう。"
            when 3 then
                "ORMの役割は理解できています。生成されるSQLも確認するとさらに理解が深まります。"
            end
        end
    end
end
