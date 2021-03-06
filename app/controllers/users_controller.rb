class UsersController < ApplicationController
  skip_before_action :require_login

  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "User #{@user.name} successfully created!"
      redirect_to ideas_path
    else
      flash.now[:danger] = "User could not be created."
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
