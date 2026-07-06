module Diagnosis
    module Questions
        class Q8
            # 質問内容: 関数を使って処理をまとめる意図を理解していますか？
            # 回答1: 処理をまとめる意味を説明できる
            # 回答2: なんとなく使っている
            # 回答3: 使い分けが分からない

            def initialize(score)
                @score = score
            end

            def call
                case @score
                when 1 then
                    "関数を基礎からやり直してみましょう。いろんな関数の処理を作って動かしてみましょう。"
                when 2 then
                    "関数を使う理由や、同じ処理をまとめるメリットを意識しながら書いてみましょう。"
                when 3 then
                    "関数の使い方は問題ありません。より関数の使い方を極めていきましょう。"
                end
            end
        end
    end
end
