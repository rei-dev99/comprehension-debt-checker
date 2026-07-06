module Diagnosis
  module CategorySummary
    class Web
      def initialize(score)
        @score = score
      end

      def call
        build_web_summary(@score)
      end

      private

      def build_web_summary(score)
        if score >= 12
          "Webの基礎はしっかり身についています。HTTP通信やAPIの流れを意識しながら実装すると、より実践的な力が身につきます。"
        elsif score >= 9
          "基本的なWebの知識は身についています。リクエストからレスポンスまでの流れを意識すると、さらに理解が深まります。"
        else
          "Webの基礎を復習すると理解が深まりそうです。まずはHTTP・URL・Cookie・Session・Webの仕組みなど、基本的な仕組みから学び直してみましょう。"
        end
      end
    end
  end
end
