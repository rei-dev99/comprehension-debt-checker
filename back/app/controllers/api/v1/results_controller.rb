class Api::V1::ResultsController < ApplicationController
  include Pagination
  before_action :set_result, only: %i[ show ]

  def index
    @results = @current_user.results.all.order(created_at: :desc).page(params[:page]).per(5)
    @pagination = resources_with_pagination(@results)

    render json: {
      results: @results,
      pagination: resources_with_pagination(@results)
    }, status: :ok
  end

  def show
    render json: @result, status: :ok
  end

  def create
    answers = params[:answers].permit!.to_h.transform_keys(&:to_i).transform_values(&:to_i)
    dependency_score = Diagnosis::Scoring::DependencyScore.new(answers).call
    scores = Diagnosis::Scoring::CategoryScore.new(answers).call
    category_results = build_category_results(scores, answers)
    advice = Diagnosis::Advice::GenerateAdvice.new(category_results).call

    result = Result.create!(
      build_result_params(scores, dependency_score, advice)
    )

    render json: result, status: :created
  end

  private

  def set_result
    @result = @current_user.results.find(params[:id])
  end

  def build_category_results(scores, answers)
    scores.map do |category, score|
      {
        category: category.name,
        summary: build_summary(category, score),
        advices: build_advices(category, answers)
      }
    end
  end

  def build_summary(category, score)
    CategorySummary
      .where(category: category)
      .find_by(
        "min_score <= ? AND max_score >= ?",
        score,
        score
      )&.summary
  end

  def build_advices(category, answers)
    answers.filter_map do |question_id, choice_id|
      choice = Choice.find(choice_id)

      next unless choice.question.category == category

      choice.feedback
    end
  end

  # resultテーブルを見直して固定のカテゴリー関係なくなるように今後保守する。
  def build_result_params(scores, dependency_score, advice)
    {
      ai_score: find_score(scores, "AI活用習慣"),
      algorithm_score: find_score(scores, "アルゴリズム基礎"),
      db_score: find_score(scores, "データベース"),
      web_score: find_score(scores, "Web基礎"),
      dependency_score: dependency_score,
      advice: advice,
      user_id: @current_user.id
    }
  end

  def find_score(scores, category_name)
    category = scores.keys.find do |category|
      category.name == category_name
    end

    scores[category]
  end
end
