class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :find_category, only: [:show, :edit, :update]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 3).order('id DESC')
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 3)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was successfully created"
      redirect_to @category
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category was updated successfully."
      redirect_to @category
    else
      render 'edit'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "You are not allowed to create/edit a new category"
      redirect_to categories_path
    end
  end

end