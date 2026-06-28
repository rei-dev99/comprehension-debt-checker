require 'rails_helper'

RSpec.describe 'Api::V1::Results', type: :request do
  describe 'GET /api/v1/results' do
    let!(:user) { create(:user) }
    let!(:result) { create(:result, user: user) }

    let(:headers) do
      {
        CONTENT_TYPE: 'application/json',
        Authorization: 'Bearer fake_token'
      }
    end

    let(:request_params) do
      {
        answers: {
            1 => 1,
            2 => 4,
            3 => 8,
            4 => 11,
            5 => 13,
            6 => 17,
            7 => 21,
            8 => 24,
            9 => 27,
            10 => 28,
            11 => 31,
            12 => 35,
            13 => 38,
            14 => 41,
            15 => 43,
            16 => 46,
            17 => 51,
            18 => 54,
            19 => 56,
            20 => 58
        }
      }
    end

    describe 'GET /api/v1/results' do
      context 'when unauthenticated' do
        it 'returns status 401' do
          get '/api/v1/results'

          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'when authenticated' do
        before do
          stub_authentication(user)
        end

        it 'returns all results with status 200' do
          get '/api/v1/results', headers: headers

          expect(response).to have_http_status(:ok)

          json = response.parsed_body

          expect(json.first).to include(
            'id',
            'ai_score',
            'algorithm_score',
            'db_score',
            'web_score',
            'dependency_score',
            'advice',
            'created_at',
            'updated_at',
            'user_id'
            )
        end
      end
    end

    describe 'GET /api/v1/results/:id' do
      before do
        stub_authentication(user)
      end

      it 'returns result detail with status 200' do
        get "/api/v1/results/#{result.id}", headers: headers

        expect(response).to have_http_status(:ok)

        json = response.parsed_body

        expect(json).to include(
            'id',
            'dependency_score',
            'advice'
        )
      end
    end

    describe 'POST /api/v1/results' do
      before do
        stub_authentication(user)

        allow_any_instance_of(DependencyScore)
          .to receive(:call)
          .and_return(65)

        allow_any_instance_of(CategoryScore)
          .to receive(:call)
          .and_return(
            ai: 10,
            algorithm: 8,
            database: 7,
            web: 5
          )

        allow_any_instance_of(GenerateAdvice)
          .to receive(:call)
          .and_return('テストアドバイス')
      end

      it 'creates result with status 201' do
        expect do
          post '/api/v1/results',
            headers: headers,
            params: request_params.to_json
        end.to change(Result, :count).by(1)

        expect(response).to have_http_status(:created)

        json = response.parsed_body

        expect(json['advice']).to eq('テストアドバイス')
        expect(json['dependency_score']).to eq(65)
      end
    end
  end
end
