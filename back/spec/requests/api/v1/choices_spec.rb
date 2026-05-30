require 'rails_helper'

RSpec.describe 'Api::V1::Choices', type: :request do
  describe 'GET /api/v1/choices' do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:question) { create(:question, category: category) }
    let!(:choice) { create(:choice, question: question) }

    context 'when unauthenticated' do
      it 'returns status 401' do
        get '/api/v1/choices'

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'Bearer fake_token' } }

      before do
        stub_authentication(user)
      end

      it 'returns all choices with status 200' do
        get '/api/v1/choices', headers: headers

        expect(response).to have_http_status(:ok)

        json = response.parsed_body

        expect(json.first).to include(
          'id',
          'content',
          'score',
          'question_id'
        )
      end
    end
  end
end
