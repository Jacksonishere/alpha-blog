class ArticlesController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  #Any signed in user can go to the edit page of someone elses article, send a patch request to another users article, or a delete request to another article. We want to prevent that 
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5).order('id DESC')
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article successfully deleted"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit your posts!"
      redirect_to user_path(current_user)
    end
  end
end