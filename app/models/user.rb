# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  #attr_accessible is a method. Thus, it is possible to write
  #both ways as attr_accessible(:email, :name)
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  #Since not all db adapters are case sensitive, it is better
  #to save the emails after converting to downcase.
  before_save { email.downcase! }
  #validates is a method. Thus, it is possible to write
  #both ways as validates(:name, presence: true)
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  					format: { with: VALID_EMAIL_REGEX }, 
  					uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end