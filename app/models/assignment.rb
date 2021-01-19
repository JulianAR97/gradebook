class Assignment < ActiveRecord::Base
  belongs_to :subject
  validates :category, presence: true, inclusion: { in: %w[homework test project]}
  validates :score_earned, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
  validates :score_possible, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
  validates :date, presence: true

  # Working, but ugly, fix please
  def self.score_as_percentage(score_earned, score_possible)
    # This allows us to convert number to a float with 2 decimal places and store as string
    format('%.2f', ((score_earned * 0.1) / (score_possible * 0.1) * 100))
  end

  def self.sort_for_table
    all.sort_by { |a| [a[:category], a[:date]] }
  end
end
