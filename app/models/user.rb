# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  # Validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: true
  
  has_secure_password

  # Direct associations
  has_many :likes, dependent: :destroy
  has_many :comments, class_name: 'Comment', foreign_key: 'commenter_id', dependent: :destroy
  has_many :sent_follow_requests, class_name: 'FollowRequest', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_follow_requests, class_name: 'FollowRequest', foreign_key: 'recipient_id', dependent: :destroy
  has_many :own_photos, class_name: 'Photo', foreign_key: 'owner_id', dependent: :destroy

  # Indirect associations
  has_many :following, through: :sent_follow_requests, source: :recipient
  has_many :followers, through: :received_follow_requests, source: :sender
  has_many :liked_photos, through: :likes, source: :photo
  has_many :feed, through: :following, source: :own_photos
  has_many :activity, through: :following, source: :liked_photos

  # Instance methods
  def following?(other_user)
    following.include?(other_user)
  end

  def sent_request_to?(other_user)
    FollowRequest.exists?(sender_id: id, recipient_id: other_user.id)
  end
end
