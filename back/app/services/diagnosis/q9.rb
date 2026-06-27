module Diagnosis
    class Q9
        # 質問内容: コードの流れを順番に追って説明できますか？
        # 回答1: 順番に追って説明できる
        # 回答2: 少しなら追える
        # 回答3: 難しい

        def initialize(score)
            @score = score
        end

        def call
            case @score
            when 1 then
                "不明点を言語化して、足りない知識があれば基礎からやり直してみましょう。"
            when 2 then
                "コードでうまく読めなかったり理解できないところがあれば、基礎に戻ってみましょう。"
            when 3 then
                "コードの流れを順番に追えているので、その調子で少し長いコードにも挑戦してみましょう。"
            end
        end
    end
end
