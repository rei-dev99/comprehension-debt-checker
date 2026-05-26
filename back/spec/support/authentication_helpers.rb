module AuthenticationHelper
  # JWT認証データはスタブで固定
  def stub_authentication
    @user = {
      uid: 'test@example.com',
      provider: 'email',
      email: 'test@example.com'
    }

    allow_any_instance_of(ApplicationController).to receive(:authenticatable!).and_return(@user)
  end
end
