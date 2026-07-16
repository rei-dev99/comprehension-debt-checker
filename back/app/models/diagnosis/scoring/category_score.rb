module Diagnosis
  module Scoring
    class CategoryScore
      def initialize(answers)
        @answers = answers
      end

      def call
        set_scores
      end

      private

      def set_scores
        scores = Hash.new(0)

        @answers.each do |question_id, choice_id|
          choice = Choice.find(choice_id)
          question = choice.question
          category = question.category

          scores[category] += choice.score
        end

        scores
      end
    end
  end
end
