# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id', required: true
  has_many :likes, class_name: 'Like', foreign_key: 'photo_id', dependent: :destroy
  has_many :comments, class_name: 'Comment', foreign_key: 'photo_id', dependent: :destroy
  
  # Indirect associations
  has_many :fans, through: :likes, source: :user
  has_many :followers, through: :owner, source: :following
  has_many :fan_followers, through: :fans, source: :following
  
  # Validations
  validates :owner_id, presence: true
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
  
end
