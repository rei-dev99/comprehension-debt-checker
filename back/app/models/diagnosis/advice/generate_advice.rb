module Diagnosis
  module Advice
    class GenerateAdvice
      def initialize(category_results)
        @category_results = category_results
      end

      def call
        build_message
      end

      private

      def build_message
        @category_results.map do |category|
          <<~TEXT
          【#{category[:category]}】
          #{category[:summary]}

          ■あなたへのアドバイス
          #{category[:advices].map { |advice| "・#{advice}" }.join("\n")}

          TEXT
        end.join("\n")
      end
    end
  end
end
