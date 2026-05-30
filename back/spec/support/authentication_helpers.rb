module AuthenticationHelper
  def stub_authentication(user)
    allow_any_instance_of(ApplicationController)
      .to receive(:authenticatable!) do |controller|
        controller.instance_variable_set(:@current_user, user)
      end
  end
end
