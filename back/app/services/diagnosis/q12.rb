module Diagnosis
    class Q12
        # 質問内容: 外部キーの役割を知っていますか？
        # 回答1: 役割を説明できる
        # 回答2: 名前は知っている
        # 回答3: 分からない

        def initialize(score)
            @score = score
        end

        def call
            case @score
            when 1 then
                "テーブルについて基礎からやり直してみて、実際に手を動かして作ってみましょう。"
            when 2 then
                "名前を知っているのはグッドです。次は外部キーを実際に設定してみてどう使われるのか理解してみましょう。"
            when 3 then
                "外部キーの役割を理解できています。実際のアプリでもどのテーブルを結び付けているか意識するとさらに理解が深まります。"
            end
        end
    end
end
