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
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :photos, class_name: 'Photo', foreign_key: 'owner_id', dependent: :destroy
  has_many :comments, class_name: 'Comment', foreign_key: 'author_id', dependent: :destroy
  has_many :likes, class_name: 'Like', foreign_key: 'fan_id', dependent: :destroy
  has_many :followrequests, class_name: 'Followrequest', foreign_key: 'recipient_id', dependent: :destroy
  has_many :sentrequests, class_name: 'Followrequest', foreign_key: 'sender_id', dependent: :destroy
  has_many :posts, through: :comments, source: :photo
end
