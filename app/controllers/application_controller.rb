class ApplicationController < ActionController::Base
before_action :basic_auth

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
