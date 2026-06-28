module Diagnosis
    class Q7
        # 質問内容: 配列の要素を取り出して扱えますか？
        # 回答1: 要素を取り出して扱える
        # 回答2: 要素番号を見ながら扱える
        # 回答3: ほとんど分からない

        def initialize(score)
            @score = score
        end

        def call
            case @score
            when 1 then
                "最初のスタートとして、配列から1つの要素を取り出したり、繰り返し処理で表示する練習をしてみましょう。"
            when 2 then
                "いい感じです。簡単な配列操作の問題を解いていくと理解が深まります。"
            when 3 then
                "配列の基本を理解できています。"
            end
        end
    end
end
