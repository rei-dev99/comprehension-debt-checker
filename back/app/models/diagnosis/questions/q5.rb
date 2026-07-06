module Diagnosis
    module Questions
        class Q5
            # 質問内容: AIを自分にとってどう使うものだと思いますか？
            # 回答1: 補助ツール
            # 回答2: 便利な相談相手
            # 回答3: 答えを全部任せる相手

            def initialize(score)
                @score = score
            end

            def call
                case @score
                when 1 then
                    "AIを答えを教えてもらう相手ではなく、学習を支える補助ツールとして考えてみましょう。"
                when 2 then
                    "AIを相談相手として活用できています。最終的な判断は自分で行う意識を持つとさらに良くなります。"
                when 3 then
                    "AIを補助ツールとして適切に活用できています。この姿勢を続けていきましょう。"
                end
            end
        end
    end
end
