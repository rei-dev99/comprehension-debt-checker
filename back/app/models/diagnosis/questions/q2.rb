module Diagnosis
    module Questions
        class Q2
            # 質問内容: AIの回答は、どのように扱いますか？
            # 回答1: 回答をそのまま使わず、内容を確認する
            # 回答2: 必要な部分だけ参考にする
            # 回答3: そのままコピペする

            def initialize(score)
                @score = score
            end

            def call
                case @score
                when 1 then
                    "コピペからとりあえずでもAIの回答を読んでいきましょう。内容を理解してから使うことを意識すると良さそうです。"
                when 2 then
                    "この調子でAIの回答を必要な箇所を参考にしながら活用していきましょう"
                when 3 then
                    "AIを参考として適切に活用できています。これからも内容を理解しながら使う習慣を続けましょう。"
                end
            end
        end
    end
end
