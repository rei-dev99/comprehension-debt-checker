class Api::V1::ChoicesController < ApplicationController
  def index
    @choices = Choice.all
    render status: :ok,
    json: @choices.as_json(
      only: [ :id, :content, :score, :question_id ]
    )
  end
end
