require 'rails_helper'

RSpec.describe "Api::V1::CategorySummaries", type: :request do
  describe "GET /api/v1/category_summaries" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:category_summary) { create(:category_summary, category: category) }

    context 'when unauthenticated' do
      it 'returns status 401' do
        get '/api/v1/category_summaries'

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'Bearer fake_token' } }

      before do
        stub_authentication(user)
      end

      it 'returns all category_summaries with status 200' do
        get '/api/v1/category_summaries', headers: headers

        expect(response).to have_http_status(:ok)

        json = response.parsed_body

        expect(json.first).to include(
          'id',
          'name',
        )

        expect(json.first['category_summaries'].first).to include(
          'id',
          'min_score',
          'max_score',
          'summary'
        )
      end
    end
  end
end
