require 'rails_helper'

RSpec.describe 'Api::V1::Authentication', type: :request do
  describe 'POST /api/v1/login' do
    let!(:user) { create(:user) }

    let(:headers) do
      {
        CONTENT_TYPE: 'application/json',
        Authorization: 'Bearer fake_token'
      }
    end

    context 'when unauthenticated' do
      it 'returns status 401' do
        post '/api/v1/login'

        expect(response).to have_http_status(:unauthorized)

        json = response.parsed_body

        expect(json).to include('error')
      end
    end

    context 'when authenticated' do
      before do
        stub_authentication(user)
      end

      it 'returns current user with status 200' do
        post '/api/v1/login', headers: headers

        expect(response).to have_http_status(:ok)

        json = response.parsed_body

        expect(json).to include('user')
      end
    end
  end

  describe 'POST /api/v1/login_email' do
    let!(:user) { create(:user) }

    let!(:credential) do
      create(
        :user_credential,
        user: user,
        email: 'test@example.com',
        password: 'password',
        provider: 'email',
        uid: 'test@example.com'
      )
    end

    context 'with valid credentials' do
      it 'returns status 200' do
        post '/api/v1/login_email',
          params: {
            email: 'test@example.com',
            password: 'password'
          }

        expect(response).to have_http_status(:ok)

        json = response.parsed_body

        expect(json).to include('user')
      end
    end

    context 'with invalid credentials' do
      it 'returns status 401' do
        post '/api/v1/login_email',
          params: {
            email: 'test@example.com',
            password: 'wrong_password'
          }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /api/v1/signup_email' do
    it 'creates user with status 201' do
      expect do
        post '/api/v1/signup_email',
          params: {
            email: 'test@example.com',
            password: 'password'
          }
      end.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)

      json = response.parsed_body

      expect(json).to include('user')
    end

    context 'when email already exists' do
      before do
        user = create(:user)

        create(
          :user_credential,
          user: user,
          email: 'test@example.com',
          provider: 'email',
          uid: 'test@example.com'
        )
      end

      it 'returns status 422' do
        post '/api/v1/signup_email',
          params: {
            email: 'test@example.com',
            password: 'password'
          }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
