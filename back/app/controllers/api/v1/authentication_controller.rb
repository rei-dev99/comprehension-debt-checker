class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticatable!, only: [ :login_email, :signup_email ]

  include Authenticatable

  def login
    render json: { user: @current_user }, status: :ok
  end

  def login_email
    credential = UserCredential.find_by(email: params[:email], provider: "email")

    if credential&.authenticate(params[:password])
      render json: { user: credential }
    else
      render json: { error: "error" }, status: :unauthorized
    end
  end

  def signup_email
    if UserCredential.exists?(email: params[:email], provider: "email")
      return render json: {
        code: "already_exists",
        "field": "email",
        message: "このメールアドレスは既に登録されています"
      }, status: :unprocessable_entity
    end

    user = User.create!(status: "active")

    credential = user.user_credentials.create!(
      email: params[:email],
      password: params[:password],
      provider: "email",
      uid: params[:email]
    )

    render json: { user: user }, status: :created
  end
end
