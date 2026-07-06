module Diagnosis
    module Questions
        class Q14
            # 質問内容: JOINが何のために使われるか分かりますか？
            # 回答1: 目的を説明できる
            # 回答2: 使ったことはある
            # 回答3: 分からない

            def initialize(score)
                @score = score
            end

            def call
                case @score
                when 1 then
                    "基本のSQLから理解していきましょう。慣れてきたらJOINを使ってテーブルの結合をやってみましょう。"
                when 2 then
                    "JOIN使ったことがあるなら、実際にSQLで試してみてどんなデータが取り出されるのか中身を確認しながら理解していきましょう。"
                when 3 then
                    "JOINの役割は理解できています。INNER JOINやLEFT JOINの違いも確認するとさらに実践で役立ちます。"
                end
            end
        end
    end
end
