class RenameOldLikestoNewLikes < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :like_count, :likes_count
    rename_column :users, :comment_count, :comments_count
  end
end
