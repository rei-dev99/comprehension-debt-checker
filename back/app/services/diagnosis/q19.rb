module Diagnosis
    class Q19
        # 質問内容: CookieとSessionの違いについて説明できますか？
        # 回答1: 違いを説明できる
        # 回答2: なんとなく知っている
        # 回答3: 分からない

        def initialize(score)
            @score = score
        end

        def call
            case @score
            when 1 then
                "CookieとSessionについて調べてみましょう。"
            when 2 then
                "なんとなくでも大丈夫。最初は混乱しやすい分野なので少しずつ理解していきましょう。"
            when 3 then
                "CookieとSessionの違いについて大丈夫そうです。実際に処理をやってみることで理解が深まります。"
            end
        end
    end
end
