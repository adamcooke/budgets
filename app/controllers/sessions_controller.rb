class SessionsController < ApplicationController

  layout 'sub'
  skip_before_filter :login_required, :only => [:new, :create]

  def create
    if user = User.authenticate(params[:email_address], params[:password])
      self.current_user = user
      redirect_to root_path
    else
      flash.now[:alert] = "The details you have entered are incorrect. Please check and try again."
      render 'new'
    end
  end

  def destroy
    auth_session.invalidate!
    reset_session
    redirect_to login_path, :notice => "You have been logged out successfully."
  end

end
