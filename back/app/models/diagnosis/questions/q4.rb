module Diagnosis
    module Questions
        class Q4
            # 質問内容: 書いたコードを見て、意図を説明できますか？
            # 回答1: 意図や動きを説明できる
            # 回答2: なんとなくは分かる
            # 回答3: 説明はできない

            def initialize(score)
                @score = score
            end

            def call
                case @score
                when 1 then
                    "おすすめなのは、コードを一行ずつ読みながら「何をしているか」を自分の言葉で説明する練習をすることです。"
                when 2 then
                    "その調子です。実際のコードの出力を確認するなどして、なんとなくわかる状態から意図を理解できる状態を目指していきましょう。"
                when 3 then
                    "コードの意図を理解しながら実装できています。この調子で他人のコードも読み解く力を伸ばしていきましょう。"
                end
            end
        end
    end
end
