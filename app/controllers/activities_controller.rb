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
    @albums = PhotoAlbum.order(start_date: :desc,title: :asc).first 10
  end

  def edit
    @activity = Activity.find params[:id]
    @albums = @activity.photo_album_id.nil? ?
      PhotoAlbum.order(start_date: :desc,title: :asc).first(10) :
      [@activity.photo_album]
  end

  def create
    @activity = Activity.new activity_params
    if @activity.save
      flash[:notice] = t(:activity_added)
      redirect_to @activity
      return
    else
      render :new
      return
    end
  end

  def update
    @activity = Activity.find params[:id]
    if @activity.update activity_params
      flash[:notice] = t(:activity_edited)
      redirect_to @activity
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @activity = Activity.find params[:id]
    if @activity.destroy
      flash[:notice] = t(:activity_deleted)
      redirect_to activity_index_path
      return
    else
      flash[:notice] = t(:activity_error_delete)
      redirect_to @activity
      return
    end
  end

  def search
    @albums = PhotoAlbum.search_with_date params.require(:search), 10

    respond_to do |format|
      format.html { render status: :not_implemented }
      format.json {
        render json: @albums.as_json(only: [:id], methods: [:title_with_year])
      }
    end
    return
  end


  private

  def activity_params
    params.require(:activity).permit(:title, :text, :date, :category_id,
    :photo_album_id)
  end

end
