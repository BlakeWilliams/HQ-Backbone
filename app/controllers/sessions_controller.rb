class SessionsController < ApplicationController
  skip_before_filter :require_login

  def create
    token = form_authenticity_token
    user = login(params[:email], params[:password])
    session[:_csrf_token] = token
    if user
      render json: true
    else
      errors = [:password]
      errors.push :email if !User.find_by_email(params[:email])
      render json: errors, status: 401
    end
  end

  def destroy
    logout
  end

end
