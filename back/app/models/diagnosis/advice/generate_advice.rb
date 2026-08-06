module Diagnosis
  module Advice
    class GenerateAdvice
      def initialize(category_results)
        @category_results = category_results
      end

      def call
        build_json_message
      end

      private

      def build_json_message
        json = Hash.new { |h, k| h[k] = {} }

        @category_results.each do |category|
          json[category[:slug]][:name] = category[:category]
          json[category[:slug]][:summary] = category[:summary]
          json[category[:slug]][:advices] = category[:advices]
        end

        json
      end
    end
  end
end
