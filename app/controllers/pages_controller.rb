class PagesController < ApplicationController

  def main    
  end

  def show
    @page = Page.where(symlink: params[:symlink]).first
    if @page.nil?
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
      return
    end
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.where(symlink: params[:symlink]).first
    if @page.nil?
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
      return
    end
  end

  def create
    @page = Page.new params.require(:page).permit(:title, :body, :symlink)
    if @page.save
      flash[:notice] = t(:page_added)
      redirect_to page_path(@page.symlink)
      return
    else
      render :new
    end
  end

  def update
    @page = Page.where(symlink: params[:symlink]).first
    if @page.nil?
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
      return
    end

    if @page.update params.require(:page).permit(:title, :body)
      flash[:notice] = t(:page_edited)
      redirect_to page_path(@page.symlink)
      return
    else
      render :edit
    end
  end

  def destroy
    @page = Page.where(symlink: params[:symlink]).first
    if @page.nil?
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
      return
    end

    if @page.symlink == 'about' || @page.symlink == 'contacts'
      flash[:alert] = t :page_is_protected
      redirect_to page_path(@page.symlink)
      return
    end

    unless @page.destroy
      flash[:alert] = t :page_is_not_deleted
      redirect_to page_path(@page.symlink)
      return
    end
    flash[:notice] = t :page_was_deleted
    redirect_to root_path
    return
  end

end
