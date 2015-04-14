class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user_login
    if !logged_in?
      flash[:danger] = "You are not logged in."
      redirect_to sign_in_path
    end
  end

  def access_denied
    flash[:danger] = "You are not permitted to do that."
    redirect_to home_path
  end

end