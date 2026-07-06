module Diagnosis
    module Questions
        class Q20
            # 質問内容: DOMやJSONの役割を理解していますか？
            # 回答1: 役割を説明できる
            # 回答2: 名前は知っている
            # 回答3: 分からない

            def initialize(score)
                @score = score
            end

            def call
                case @score
                when 1 then
                    "JSONを実際に表示してみたり、DOMを操作する簡単なサンプルを動かしてみると理解しやすくなります。"
                when 2 then
                    "実際にDOMやJSONを操作してみたり、簡単なAPI通信を作ることにも挑戦すると理解が深まります。"
                when 3 then
                    "DOMやJSONの役割は理解できています。簡単なAPI通信などを作るとさらに理解が深まります。"
                end
            end
        end
    end
end
