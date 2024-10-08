class PhotosController < ApplicationController
  def index
    @photos = Photo.all.order(created_at: :desc)
  end

  def show
   if  @current_user == nil
    redirect_to("/users/sign_in", notice: "You need to sign in or sign up before continuing.")

   else
    the_id = params.fetch(:path_id)
    @photo = Photo.where({ :id => the_id }).first
    render({ :template => "photos/show" })
   end
  end

  def new
    @photo = Photo.new
  end

  def create
    the_photo = Photo.new
    the_photo.caption = params.fetch("caption")
    the_photo.image = params.fetch("query_image")
    the_photo.owner_id = params.fetch("query_owner_id")


    redirect_to("/photos", notice: "Photo created successfully")

  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      redirect_to photo_path(@photo), notice: 'Photo updated successfully.'
    else
      render :edit, alert: @photo.errors.full_messages.to_sentence
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_path, notice: 'Photo deleted successfully.'
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image, :owner_id)
  end
end
