class Subject < ActiveRecord::Base
    belongs_to :user
    has_many :assignments

    def self.find_by_slug(slug)
        all.find { |s| s.slugify == slug }
    end

    def slugify
        title.downcase.gsub(' ', '-')
    end
end