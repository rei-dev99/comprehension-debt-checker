module Diagnosis
    class Q11
        # 質問内容: テーブル同士の関連付けについて説明できますか？
        # 回答1: 関連付けの意味を説明できる
        # 回答2: なんとなく知っている
        # 回答3: 分からない

        def initialize(score)
            @score = score
        end

        def call
            case @score
            when 1 then
                "関連付けの理解はこれから伸ばせます。まずは1対多・多対多の関係を実際にテーブルを作りながら確認してみましょう。"
            when 2 then
                "関連付けは大事な概念なので、「なんとなく」から「理解した！」状態に持っていきましょう。"
            when 3 then
                "関連付けの考え方は理解できています。この調子で設計にも活かしていきましょう。"
            end
        end
    end
end
