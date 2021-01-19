class User < ActiveRecord::Base
  has_many :subjects
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { within: 8..40 }
end