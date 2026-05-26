require 'rails_helper'

RSpec.describe 'Api::V1::Questions', type: :request do
  describe 'GET /api/v1/questions' do
    let!(:category) { create(:category) }
    let!(:questions) { create_list(:question, 20, category: category) }

    it 'returns all questions with status 200' do
      get '/api/v1/questions'

      expect(response).to have_http_status(:ok)

      json = response.parsed_body

      expect(json.length).to eq(20)
      expect(json.first).to include(
        'id',
        'content',
        'category'
      )
    end
  end
end
