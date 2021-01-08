class User < ActiveRecord::Base
    has_many :subjects
    has_secure_password
end