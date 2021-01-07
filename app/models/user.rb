class User < ActiveRecord::Base
    has_many :user_subjects
    has_many :subjects, through: :user_subjects
    has_many :assignments, through: :subjects
end