class Api::V1::ResultsController < ApplicationController
  before_action :set_result, only: %i[ show ]

  def index
    @results = @current_user.results.all.order(created_at: :desc)
    render status: :ok, json: @results
  end

  def show
    render json: @result, status: :ok
  end

  def create
    answers = params[:answers]

    scores, dependency_score = DependencyScore.new(answers).call
    advice = GenerateAdvice.new(scores, dependency_score).call

    result = Result.create!(
      ai_score: scores[:ai],
      algorithm_score: scores[:algorithm],
      db_score: scores[:db],
      web_score: scores[:web],
      dependency_score: dependency_score,
      advice: advice,
      user_id: @current_user.id
    )

    render json: result, status: :created
  end

  private

  def set_result
    @result = @current_user.results.find(params[:id])
  end
end
