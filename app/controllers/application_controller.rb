class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :login_required

  rescue_from Authie::Session::InactiveSession, :with => :auth_session_error
  rescue_from Authie::Session::ExpiredSession, :with => :auth_session_error
  rescue_from Authie::Session::BrowserMismatch, :with => :auth_session_error

  private

  def budget
    @budget_global ||= current_user.budgets.find_by_uuid(params[:budget_id]) || :false
  end
  helper_method :budget

  def budget_required
    unless budget.is_a?(Budget)
      raise ActiveRecord::RecordNotFound, "Budget required but not found"
    end
  end

  def login_required
    unless logged_in?
      redirect_to login_path
    end
  end

  def redirect_to_with_return_to(path, *args)
    if params[:return_to].present?
      redirect_to params[:return_to], *args
    else
      redirect_to path, *args
    end
  end

  def auth_session_error
    redirect_to login_path
  end

end
