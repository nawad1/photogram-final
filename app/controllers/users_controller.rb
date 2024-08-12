class UsersController < ApplicationController

  
  def index
    @users = User.all.order({ :username => :asc })

    render({ :template => "users/index" })
  end

  def show
  
    if @current_user == nil
      redirect_to :controller => 'user_authentication', :action => 'sign_in_form'
    else 
      the_username = params.fetch(:username)
      @user = User.find_by(username: the_username)
      render({ :template => "users/show" })
    end
  end

  def follow
    @user = User.find(params[:id])
  
    unless current_user.following?(@user)
      if @user.private?
        # Create a follow request
        follow_request = FollowRequest.new(sender: current_user, recipient: @user)
        follow_request.save if follow_request.persisted?
      else
        # Perform the follow logic
        current_user.following << @user
      end
    end
  
    redirect_to user_path(@user)
  end
  
  def unfollow
    @user = User.find(params[:id])
    current_user.following.delete(@user) if current_user.following?(@user)
    redirect_to user_path(@user.username)
  end
  
  def cancel_request
    @user = User.find(params[:user_id])
    follow_request = FollowRequest.find_by(sender: current_user, recipient: @user)
    
    if follow_request
      if authorized_to_cancel?(current_user, follow_request)
        follow_request.destroy
        flash[:notice] = "Follow request cancelled"
      else
        flash[:alert] = "You're not authorized for that."
      end
    else
      flash[:alert] = "No follow request found"
    end
    
    redirect_back(fallback_location: root_path)
  end
  
  
  def authorized_to_cancel?(user, follow_request)
    # replace with your authorization logic
    user == follow_request.sender
  end


  def feed
    @user = User.find_by(username: params[:username])
    following_ids = FollowRequest.where(recipient_id: @user.id, status: 'accepted').pluck(:sender_id)
    @photos = Photo.where(owner_id: following_ids).order(created_at: :desc)
    
    render :feed
  end

  def discovery
    @user = User.find_by(username: params[:username])
    following_ids = FollowRequest.where(sender_id: @user.id, status: 'accepted').pluck(:recipient_id)
    liked_photo_ids = Like.where(fan_id: following_ids).pluck(:photo_id).uniq
    @photos = Photo.where(id: liked_photo_ids).order(created_at: :desc)
    
    html = "<h1>Discover Photos</h1>"

    if photos.any?
      html += "<ul>"
      photos.each do |photo|
        html += "<li>"
        html += "<img src='#{photo.image.url}' alt='#{photo.caption}' style='max-width: 300px;' />"
        html += "<p>#{photo.caption}</p>"
        html += "<p>Posted by: #{User.find(photo.owner_id).username}</p>"
        html += "</li>"
      end
      html += "</ul>"
    else
      html += "<p>No photos found in discover.</p>"
    end

    render html: html.html_safe
  end

  def liked_photos
    @user = User.find_by(username: params[:username])
    @photos = Photo.joins(:likes).where(likes: { fan_id: @user.id }).order('likes.created_at DESC')
    
    render :liked_photos
  end
  
  def edit
    @user = User.find(params[:id])
    if @user.errors.any?
      render 'edit_profile_with_errors'
    else
      render 'edit_profile'
    end
  end

end
