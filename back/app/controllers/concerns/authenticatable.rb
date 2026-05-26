module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticatable!
    attr_reader :current_user
  end

  def authenticatable!
    token = request.authorization&.split(" ")&.last

    # トークン確認用
    # Rails.logger.debug "JWT Token: #{token}"

    unless token
      render json: { error: "Unauthorized" }, status: :unauthorized
      return
    end

    public_key = OpenSSL::PKey::RSA.new(
      File.read(Rails.root.join("config/keys/public.pem"))
    )

    decoded_token = JWT.decode(token, public_key, true, { algorithm: "RS256" })
    payload = decoded_token.first

    email = payload["email"]
    provider = payload["provider"]
    uid = payload["uid"]

    if uid.blank? || provider.blank?
      head :unauthorized
      return
    end

    credential = UserCredential.find_by(provider: provider, uid: uid)

    if credential
      @current_user = credential.user
    else
      ActiveRecord::Base.transaction do
        user = User.create!(status: "active")
        user.user_credentials.create!(
          provider: provider,
          uid: uid,
          email: email
        )
        @current_user = user
      end
    end

  rescue JWT::DecodeError, JWT::ExpiredSignature
    head :unauthorized
  end
end
