module Diagnosis
    module Questions
        class Q18
            # 質問内容: HTTP通信の基本的な流れを知っていますか？
            # 回答1: 基本的な流れを知っている
            # 回答2: 名前は知っている
            # 回答3: 分からない

            def initialize(score)
                @score = score
            end

            def call
                case @score
                when 1 then
                    "書籍とかネットで「HTTP 通信とは？」から調べてみましょう。"
                when 2 then
                    "HTTPリクエストとHTTPレスポンスについて調べて理解していきましょう。"
                when 3 then
                    "HTTP通信について良さそうです。HTTPの概念から深いところまで調べて活用していきましょう。"
                end
            end
        end
    end
end
