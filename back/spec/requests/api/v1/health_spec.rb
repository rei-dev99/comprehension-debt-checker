require 'rails_helper'

RSpec.describe 'Api::V1::Health', type: :request do
  describe 'GET /api/v1/health' do
    it 'returns status 200' do
      get '/api/v1/health'

      expect(response).to have_http_status(:ok)
    end
  end
end
