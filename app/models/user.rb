# == Schema Information
#
# Table name: users
#
#  id             :bigint           not null, primary key
#  comments_count :integer
#  email          :string
#  likes_count    :integer
#  password       :string
#  private        :boolean
#  username       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

end
