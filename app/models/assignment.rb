class Assignment < ActiveRecord::Base
    belongs_to :subject

    # Working, but ugly, fix please
    def self.score_as_percentage(score_earned, score_possible)
        "%.2f" % ((score_earned * 0.1) / (score_possible * 0.1) * 100) + "%"
    end

    def self.sort_for_table
        all.sort_by { |a| [a[:category], a[:date]] }
    end

    def display_date
        # Date is written as 2020-12-08, and I don't care about the year for display
        date.split('-')[1..2].join('/')
    end
end
