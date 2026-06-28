module Diagnosis
    class Q3
        # 質問内容: AIを使う前に、自分で確認することはありますか？
        # 回答1: まず自分で考えてから使う
        # 回答2: 分からない時だけ使う
        # 回答3: 考える前に使うことが多い

        def initialize(score)
            @score = score
        end

        def call
            case @score
            when 1 then
                "最初の一歩として、AIを使う前に5分程度でいいので自力で問題に対するアプローチを考えてみましょう。"
            when 2 then
                "分からないときにAIを活用できています。まず自分で考える習慣も続けることで、理解がさらに深まります。"
            when 3 then
                "自分で考えてからAIを活用できています。この姿勢を続けることで問題解決力も伸ばしていけます。"
            end
        end
    end
end
