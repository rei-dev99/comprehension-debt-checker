module Diagnosis
  module Advice
    class GenerateAdvice
      def initialize(dependency_score, answers, summaries)
        @dependency_score = dependency_score
        @answers = answers
        @summaries = summaries
      end

      def call
        build_message
      end

      private

      def build_message
        advices = build_question_advices(@answers)
        <<~ADVICE
        【AI活用】
        #{@summaries[:ai]}

        ■あなたへのアドバイス
        #{advices[:ai].map { |advice| "・#{advice}" }.join("\n") }

        【アルゴリズム】
        #{@summaries[:algorithm]}

        ■あなたへのアドバイス
        #{advices[:algorithm].map { |advice| "・#{advice}" }.join("\n") }

        【データベース】
        #{@summaries[:database]}

        ■あなたへのアドバイス
        #{advices[:database].map { |advice| "・#{advice}" }.join("\n") }

        【Web基礎】
        #{@summaries[:web]}

        ■あなたへのアドバイス
        #{advices[:web].map { |advice| "・#{advice}" }.join("\n") }
        ADVICE
      end

      def build_question_advices(answers)
        result = {
          ai: [],
          algorithm: [],
          database: [],
          web: []
        }

        answers.each do |question_id, choice_id|
          choice = Choice.find(choice_id)
          question = choice.question
          category = question.category

          klass = "Diagnosis::Questions::Q#{question.id}".constantize
          advice = klass.new(choice.score).call

          case category.name
          when "AI活用習慣"
            result[:ai] << advice
          when "アルゴリズム基礎"
            result[:algorithm] << advice
          when "データベース"
            result[:database] << advice
          when "Web基礎"
            result[:web] << advice
          end
        end

        result
      end
    end
  end
end
