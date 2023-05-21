class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth
  before_action :user_set

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:nickname])
  end

  def user_set
    if user_signed_in?
      @user = User.find(current_user.id)
    end
  end
end
