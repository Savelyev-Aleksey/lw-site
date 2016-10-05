class ActivitiesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @activities = Activity.order(date: :desc).page params[:page]
  end

  def show
    @activity = Activity.find params[:id]
  end

  def new
    @activity = Activity.new
    @activity.date = Date.today
  end

  def edit
    @activity = Activity.find params[:id]
  end

  def create
    @activity = Activity.new activity_params
    if @activity.save
      flash[:notice] = t(:activity_added)
      redirect_to @activity
    else
      render :new
    end
  end

  def update
    @activity = Activity.find params[:id]
    if @activity.update activity_params
      flash[:notice] = t(:activity_edited)
      redirect_to @activity
    else
      render :edit
    end
  end

  def destroy
    @activity = Activity.find params[:id]
    if @activity.destroy
      flash[:notice] = t(:activity_deleted)
      redirect_to activity_index_path
    else
      flash[:notice] = t(:activity_error_delete)
      redirect_to @activity
    end
  end


  private

  def activity_params
    params.require(:activity).permit(:title, :text, :date, :category_id)
  end

end
