module Diagnosis
    class Q16
        # 質問内容: GETとPOSTの違いを説明できますか？
        # 回答1: 説明できる
        # 回答2: 違いは何となく分かる
        # 回答3: 分からない

        def initialize(score)
            @score = score
        end

        def call
            case @score
            when 1 then
                "HTTPメソッドについて調べてみて、どんなものがあるのか確認してみましょう。"
            when 2 then
                "他のHTTPメソッドについても調べてみましょう。"
            when 3 then
                "GETとPOSTの役割は理解できています。次はPUTやDELETEも合わせて覚えると理解が広がります。"
            end
        end
    end
end
