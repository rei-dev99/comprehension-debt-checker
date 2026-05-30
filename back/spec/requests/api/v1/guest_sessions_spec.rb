require 'rails_helper'

RSpec.describe 'Api::V1::GuestSessions', type: :request do
  describe 'POST /api/v1/guest_login' do
    it 'returns guest user with status 200' do
      post '/api/v1/guest_login'

      expect(response).to have_http_status(:ok)

      json = response.parsed_body

      expect(json).to include('user')
    end
  end
end
