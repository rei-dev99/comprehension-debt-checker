module Diagnosis
    class Q10
        # 質問内容: 簡単な処理を自分で組み立てるのは得意ですか？
        # 回答1: 自分で組み立てられる
        # 回答2: 簡単ならできる
        # 回答3: まだ難しい

        def initialize(score)
            @score = score
        end

        def call
            case @score
            when 1 then
                "少しずつ複数の処理を組み合わせた問題にも挑戦してみましょう。"
            when 2 then
                "簡単な処理を組み立てつつ、時には新しいメソッドやアルゴリズムなども学びつつ、活用してみましょう。"
            when 3 then
                "いい感じです。複雑な処理も組み立てられるようにアルゴリズム学習を続けていきましょう。"
            end
        end
    end
end
