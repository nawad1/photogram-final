class LikesController < ApplicationController
  def index
    @list_of_likes = Like.all.order(created_at: :desc)
    render template: "likes/index"
  end

  def show
    the_id = params[:path_id]
    @the_like = Like.find_by(id: the_id)
    render template: "likes/show"
  end

  def create
    the_like = Like.new
    the_like.user_id = @current_user.id
    the_like.photo_id = params[:query_photo_id]

    if the_like.save
      redirect_to("/photos/#{the_like.photo_id}", notice: "Like created successfully.")
    else
      redirect_to("/photos/#{the_like.photo_id}", notice: "Like created successfully.")
    end
  end

  def update
    the_id = params[:path_id]
    the_like = Like.find_by(id: the_id)

    the_like.user_id = params[:query_user_id]
    the_like.photo_id = params[:query_photo_id]

    if the_like.save
      redirect_to("/likes/#{the_like.id}", notice: "Like updated successfully.")
    else
      redirect_to("/likes/#{the_like.id}", alert: the_like.errors.full_messages.to_sentence)
    end
  end

  def destroy
  
      redirect_to("/likes", notice: "Like deleted successfully.")
  end

end
