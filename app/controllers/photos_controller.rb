class PhotosController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @albums = PhotoAlbum.order(created_at: :desc).page params[:page]
  end

  def show
    @album = PhotoAlbum.find params[:id]
  end

  def new
    @album = PhotoAlbum.new
  end

  def edit
    @album = PhotoAlbum.find params[:id]
  end

  def create
    @album = PhotoAlbum.new photo_album_params
    if @album.save
      flash[:notice] = t(:album_created)
      redirect_to photo_path(@album)
    else
      render :new
    end
  end

  def update
    @album = PhotoAlbum.find params[:id]
    if @album.update photo_album_params
      flash[:notice] = t(:album_edited)
      redirect_to photo_path(@album)
    else
      render :edit
    end
  end

  def destroy
    @album = PhotoAlbum.find params[:id]
    if @album.destroy
      flash[:notice] = t(:album_deleted)
      redirect_to photos_path
    else
      flash[:notice] = t(:album_error_delete)
      redirect_to @album
    end
  end

  def add_image
    @album = PhotoAlbum.find params[:id]
    if params[:photos] && (params[:photos][:picture].is_a?(Array))
        params[:photos][:picture].each do |pic|
          @album.photos.build picture: pic
        end
      else
        @album.photos.build params.require(:photos).permit(:picture)
    end
    if @album.save
      respond_to do |format|
        format.html { redirect_to photo_path(@album) }
        format.json {
          render json: {
            thumb: render_to_string(partial: 'thumb', layout: false,
            formats: [:html], locals:{photo: @album.photos.last})
          }
        }
      end
    else

      respond_to do |format|
        format.html {
          flash[:alert] = @album.errors.messages
          redirect_to photo_path(@album) }

        format.json {
          render json: {error: @album.errors.full_messages.join(',')},
                        status: :unprocessable_entity}
      end
    end
  end

  def remove_image
    @album = PhotoAlbum.find params[:album_id]
    @photo = @album.photos.find params[:id]
    if @photo.destroy
      respond_to do |format|
        format.html {
          flash[:alert] = t :photo_deleted
          redirect_to photo_path(@album) }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html {
          flash[:alert] = @photo.errors.full_messages.join(',')
          redirect_to photo_path(@album) }
        format.json {
          render json: {error: @photo.errors.full_messages.join(',')},
                        status: :unprocessable_entity}
      end
    end
  end

  def change_cover
    @photo = Photo.find params[:id]
    if @photo
      @photo.photo_album.update_attributes cover_id: @photo.id
      respond_to do |format|
        format.html {
          flash[:alert] = t :photo_cover_updated
          redirect_to photo_path(@photo.photo_album) }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html {
          flash[:alert] = t :photo_not_found
          redirect_to root_path }
        format.json {
          render json: {error: t(:photo_not_found)},
                        status: :unprocessable_entity}
      end
    end
  end


  private

  def photo_album_params
    params.require(:photo_album).permit(:title, :description)
  end


end
