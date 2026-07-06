module Diagnosis
    module Questions
        class Q6
            # 質問内容: if文とfor文を組み合わせて処理の流れを考えられますか？
            # 回答1: 処理の流れを含めて説明できる
            # 回答2: 繰り返し処理ということは分かる
            # 回答3: よく分からない

            def initialize(score)
                @score = score
            end

            def call
                case @score
                when 1 then
                    "if文と繰り返し処理を別々に書いて処理を理解し、そこからif文と繰り返しを組み合わせる練習をしてみましょう。"
                when 2 then
                    "まずは一歩いい感じです。次は条件による処理の理解も深めていきましょう。"
                when 3 then
                    "処理の流れを理解できています。"
                end
            end
        end
    end
end
