module Diagnosis
    module Questions
        class Q1
            # 質問内容: エラーが出た時、まず何をしますか？
            # 回答1: エラー文を読み、自分で原因を整理してから調べる
            # 回答2: まずコードを見直してからAIを使う
            # 回答3: すぐにAIに貼り付ける

            def initialize(score)
                @score = score
            end

            def call
                case @score
                when 1 then
                    "最初は、5分とか数分でいいので自分で考えてみましょう。"
                when 2 then
                    "いい傾向です。コードを見直したらエラーも確認してみましょう。"
                when 3 then
                    "しっかりと自分で考える習慣が身についています。この調子で、原因を整理してからAIを活用する姿勢を続けていきましょう。"
                end
            end
        end
    end
end
