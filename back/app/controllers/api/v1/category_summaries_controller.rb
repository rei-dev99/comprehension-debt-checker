class Api::V1::CategorySummariesController < ApplicationController
  def index
    @category_summaries = Category.all.includes(:category_summaries)
    render status: :ok,
    json: @category_summaries.as_json(
      only: [ :id, :name ],
      include: {
        category_summaries: {
          only: [ :id, :min_score, :max_score, :summary ]
        }
      }
    )
  end
end
