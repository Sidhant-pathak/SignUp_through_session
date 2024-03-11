class SessionsController < ApplicationController
  skip_before_action :current_user, only: :create
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to profile_path(current_user), notice: "Logged in successfully!"
      # redirect_to session.delete(:return_to) || root_path
    else
        flash.now[:alert] = "Invalid email or password"
        render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
