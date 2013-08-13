class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  rescue_from ActiveRecord::ActiveRecordError, :with => :handle_active_record_error

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def handle_active_record_error(error)
    flash[:notice] = error.message
    redirect_to(request.referrer || root_path)
  end
end
