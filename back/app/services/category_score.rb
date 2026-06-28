class CategoryScore
  def initialize(answers)
    @answers = answers
  end

  def call
    set_scores
  end

  private

  def set_scores
    scores = {
      ai: 0,
      algorithm: 0,
      database: 0,
      web: 0
    }

    @answers.each do |question_id, choice_id|
      choice = Choice.find(choice_id)
      question = choice.question
      category = question.category

      case category.name
      when "AI活用習慣"
        scores[:ai] += choice.score
      when "アルゴリズム基礎"
        scores[:algorithm] += choice.score
      when "データベース"
        scores[:database] += choice.score
      when "Web基礎"
        scores[:web] += choice.score
      end
    end

    scores
  end
end
