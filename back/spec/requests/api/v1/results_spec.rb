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

          expect(json['results'].first).to include(
            'id',
            'ai_score',
            'algorithm_score',
            'db_score',
            'web_score',
            'dependency_score',
            'advices',
            'created_at',
            'updated_at',
            'user_id'
            )

          expect(json['pagination']).to include(
            'current',
            'previous',
            'next',
            'limit_value',
            'pages',
            'count'
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
            'advices'
        )
      end
    end

    describe 'POST /api/v1/results' do
      let!(:ai_category) { create(:category, name: 'AI活用習慣', slug: 'ai') }
      let!(:algorithm_category) { create(:category, name: 'アルゴリズム基礎', slug: 'algorithm') }
      let!(:database_category) { create(:category, name: 'データベース', slug: 'db') }
      let!(:web_category) { create(:category, name: 'Web基礎', slug: 'web') }

      let!(:answers) do
        {}.tap do |hash|
          [
            ai_category,
            algorithm_category,
            database_category,
            web_category
          ].each do |category|
            question = create(:question, category: category)

            choice = create(
              :choice,
              question: question,
              feedback: 'テストフィードバック'
            )

            hash[question.id] = choice.id
          end
        end
      end

      let(:request_params) do
        {
          answers: answers
        }
      end

      before do
        stub_authentication(user)

        categories = [
          ai_category,
          algorithm_category,
          database_category,
          web_category
        ]

        categories.each do |category|
          create(
            :category_summary,
            category: category,
            min_score: 0,
            max_score: 15,
            summary: "#{category.name}まとめ"
          )
        end

        allow_any_instance_of(Diagnosis::Scoring::DependencyScore)
          .to receive(:call)
          .and_return(65)

        allow_any_instance_of(Diagnosis::Scoring::CategoryScore)
          .to receive(:call)
          .and_return(
            {
              ai_category => 10,
              algorithm_category => 8,
              database_category => 7,
              web_category => 5
            }
          )
      end

      it 'creates result with status 201' do
        expect do
          post '/api/v1/results',
            headers: headers,
            params: request_params.to_json
        end.to change(Result, :count).by(1)

        expect(response).to have_http_status(:created)

        json = response.parsed_body

        expect(json['advices']['ai']['summary']).to eq("AI活用習慣まとめ")
        expect(json['dependency_score']).to eq(65)
      end
    end
  end
end
