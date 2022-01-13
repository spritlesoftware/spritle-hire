class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      attributes = [:name, :email, :mobile, :status, :took_test, :user_type]
      devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    end
end
