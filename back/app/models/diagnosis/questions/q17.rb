module Diagnosis
    module Questions
        class Q17
            # 質問内容: HTTPのステータスコードを見て大まかな意味が分かりますか？
            # 回答1: 意味がだいたい分かる
            # 回答2: 見たことはある
            # 回答3: 分からない

            def initialize(score)
                @score = score
            end

            def call
                case @score
                when 1 then
                    "最初は、書籍とかネットで「HTTP ステータスコードとは？」から調べることから始めましょう。"
                when 2 then
                    "よく見かける代表的なステータスコードが何を表すのか調べてみましょう。"
                when 3 then
                    "代表的なステータスコードの番号と処理結果を理解していきましょう。"
                end
            end
        end
    end
end
