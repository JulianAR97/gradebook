class User < ActiveRecord::Base
    has_many :assignments
end