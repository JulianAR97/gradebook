class User < ActiveRecord::Base
    has_many :subjects
end