class UsersController < ApplicationController
    before_action :require_login, only: [:profile]
    skip_before_action :current_user, only: :create
  
  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Signed up Successfilly! Please log in."
    else
      render 'new'
    end
  end

  def profile
    # @user = User.find(params[:id])

    @user = current_user
    if @user.nil?
      redirect_to login_path, alert: 'Please Login in!'
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_login

    unless current_user
      redirect_to login_path, alert: 'Please Log in!'
    end
      
  end
end