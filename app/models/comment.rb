# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  photo_id   :integer
#
class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', counter_cache: true
  belongs_to :photo, class_name: 'Photo', foreign_key: 'photo_id', counter_cache: true

  validates :author, presence: true
  validates :photo, presence: true
end
