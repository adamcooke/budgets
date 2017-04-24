class UserController < ApplicationController

  skip_before_filter :login_required, :only => [:new, :create]

  def new
    @user = User.new
    render :layout => 'sub'
  end

  def create
    @user = User.new(safe_params)
    if @user.save
      self.current_user = @user
      redirect_to root_path, :notice => "Your new account has been created - you can now start using Budgets!"
    else
      render :action => 'new', :layout => 'sub'
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(safe_params)
      redirect_to root_path, :notice => "Your details have been updated successfully."
    else
      render 'edit'
    end
  end

  private

  def safe_params
    params.require(:user).permit(:first_name, :last_name, :email_address, :password, :password_confirmation)
  end

end
