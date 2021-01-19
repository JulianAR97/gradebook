class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :assignments
  validates :title, presence: true, uniqueness: true, length: { within: 2..20 }

  before_validation :make_title_case

  def self.find_by_slug(slug)
    all.find { |s| s.slugify == slug }
  end

  def slugify
    title.downcase.gsub(' ', '-')
  end

  private

  def make_title_case
    self.title = self.title.titlecase
  end
end