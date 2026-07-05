class UserCredential < ApplicationRecord
  belongs_to :user

  # OAuthユーザーはpasswordを持たないため、
  # has_secure_passwordのデフォルトバリデーションを無効化し、
  # email認証時のみpasswordを検証する。
  has_secure_password validations: false

  validates :provider, presence: true
  validates :uid, presence: true

  validates :email, presence: true, uniqueness: true, if: -> { provider == "email" }
  validates :password, presence: true, length: { minimum: 8 }, if: -> { provider == "email" }
end
