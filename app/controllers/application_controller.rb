class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

  def not_authenticated
    render json: 'unauthenticated', status: 403
  end
end
