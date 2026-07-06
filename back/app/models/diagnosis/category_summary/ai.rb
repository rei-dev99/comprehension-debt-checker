module Diagnosis
  module CategorySummary
    class Ai
      def initialize(score)
        @score = score
      end

      def call
        build_ai_summary(@score)
      end

      private

      def build_ai_summary(score)
        if score >= 12
          "AIを適切に活用できています。今のようにAIを参考にしつつ、自分で考える時間も続けることで、理解をさらに深められます。"
        elsif score >= 9
          "AIは活用できていますが、自分で考える時間も意識するとさらに理解が深まります。AIの回答をそのまま使うのではなく、「なぜそうなるのか」を確認する習慣を続けてみましょう。"
        else
          "AIに頼る場面がやや多い傾向があります。まずは5分だけ自分で考えてからAIを使う習慣を取り入れると、自力で解決できる力が身につきます。"
        end
      end
    end
  end
end
