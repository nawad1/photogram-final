# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  photo_id   :integer
#  user_id    :integer
#
class Like < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id', required: true
  belongs_to :photo, class_name: 'Photo', foreign_key: 'photo_id', counter_cache: true, required: true
  
  # Validations
  validates :user_id, presence: true
  validates :photo_id, presence: true, uniqueness: { scope: :user_id, message: 'already liked' }
  

end
