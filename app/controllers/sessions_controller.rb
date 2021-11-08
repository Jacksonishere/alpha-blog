class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username: signin_params[:username].downcase)
    if user && user.authenticate(signin_params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back!"
      redirect_to articles_path
    else
      flash.now[:alert] = "Wrong username or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end

  private

  def signin_params
    params.require(:session).permit(:username, :password)
  end
end
