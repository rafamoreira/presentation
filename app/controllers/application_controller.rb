class ApplicationController < ActionController::Base
  before_action :http_basic_authenticate

  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == "admin" && password == "password123"
    end
  end
end
