class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.order(title: :asc).all
    @category = Category.new
  end

  def show
    @category = Category.find params[:id]
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find params[:id]
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:notice] = t(:category_added)
      redirect_to categories_path
      return
    else
      render :new
      return
    end
  end

  def update
    @category = Category.find params[:id]
    if @category.update category_params
      flash[:notice] = t(:category_edited)
      redirect_to categories_path
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @category = Category.find params[:id]
    if @category.destroy
      flash[:notice] = t(:category_deleted)
      redirect_to categories_path
      return
    else
      flash[:notice] = t(:category_error_delete)
      redirect_to categories_path
      return
    end
  end


  private

  def category_params
    params.require(:category).permit(:title, :color)
  end
end
