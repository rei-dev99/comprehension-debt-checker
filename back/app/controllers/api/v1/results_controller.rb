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
    answers = params[:answers]

    # 回答からカテゴリー別スコアを集計
    scores = Diagnosis::Scoring::CategoryScore.new(answers).call

    # AI活用に関する回答のみをもとに依存度を算出
    dependency_score = Diagnosis::Scoring::DependencyScore.new(answers).call

    # 各カテゴリーの総評を生成
    summaries = build_summaries(scores)

    # 総評と質問別アドバイスを組み合わせて診断結果を作成
    advice = Diagnosis::Advice::GenerateAdvice.new(dependency_score, answers, summaries).call

    result = Result.create!(
      build_result_params(scores, dependency_score, advice)
    )

    render json: result, status: :created
  end

  private

  def set_result
    @result = @current_user.results.find(params[:id])
  end

  def build_summaries(scores)
    {
      ai: Diagnosis::CategorySummary::Ai.new(scores[:ai]).call,
      algorithm: Diagnosis::CategorySummary::Algorithm.new(scores[:algorithm]).call,
      database: Diagnosis::CategorySummary::Database.new(scores[:database]).call,
      web: Diagnosis::CategorySummary::Web.new(scores[:web]).call
    }
  end

  def build_result_params(scores, dependency_score, advice)
    {
      ai_score: scores[:ai],
      algorithm_score: scores[:algorithm],
      db_score: scores[:database],
      web_score: scores[:web],
      dependency_score: dependency_score,
      advice: advice,
      user_id: @current_user.id
    }
  end
end
