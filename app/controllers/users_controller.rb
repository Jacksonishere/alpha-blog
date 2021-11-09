class UsersController < ApplicationController
  before_action :require_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index 
    @users = User.paginate(page: params[:page], per_page: 5).order('id DESC')
  end 
  
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 3).order('id DESC')

  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to AlphaBlog #{@user.username}!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was updated successfully."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    if !current_user.admin? 
      session[:user_id] = nil
      flash[:notice] = "Your account has been deleted"
    else
      flash[:notice] = "Account has been removed"
    end
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit your own account"
      redirect_to current_user
    end
  end
end
