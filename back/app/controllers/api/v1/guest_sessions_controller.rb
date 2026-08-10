class Api::V1::GuestSessionsController < ApplicationController
  skip_before_action :authenticatable!

  def guest_login
    email = "#{SecureRandom.alphanumeric(7)}@example.com"
    password = SecureRandom.alphanumeric(10)

    user = User.create!(status: "active")

    credential = user.user_credentials.create!(
      user: user,
      provider: "guest",
      uid: email,
      email: email,
      password: password
    )

    render json: { user: credential.as_json(except: :password_digest) }
  end
end
