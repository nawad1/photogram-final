class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    @list_of_comments = Comment.all.order(created_at: :desc)
    render template: "comments/index"
  end

  def show
    render template: "comments/show"
  end

  def create
    comment = Comment.new
    comment.author_id = session.fetch(:user_id) # Ensure this matches your session setup
    comment.photo_id = params.fetch("query_photo_id")
    comment.body = params.fetch("query_body")
  
    if comment.save
      redirect_to("/photos/#{comment.photo_id}", notice: "Comment created successfully.")
    else
      redirect_to("/photos/#{comment.photo_id}", alert: comment.errors.full_messages.to_sentence)
    end
  end

  def update
    @comment.author_id = params.fetch("query_author_id")
    @comment.body = params.fetch("query_body")
    @comment.photo_id = params.fetch("query_photo_id")

    if @comment.save
      redirect_to("/comments/#{@comment.id}", notice: "Comment updated successfully.")
    else
      redirect_to("/comments/#{@comment.id}", alert: @comment.errors.full_messages.to_sentence)
    end
  end

  def destroy
    @comment.destroy
    redirect_to("/comments", notice: "Comment deleted successfully.")
  end

  private

  def set_comment
    @comment = Comment.find(params.fetch("path_id"))
  rescue ActiveRecord::RecordNotFound
    redirect_to("/comments", alert: "Comment not found.")
  end
end
