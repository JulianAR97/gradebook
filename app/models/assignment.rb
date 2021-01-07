class Assignment < ActiveRecord::Base
    belongs_to :user

    def self.score_as_percentage(score_earned, score_possible)
        "%.2f" % ((score_earned * 0.1) / (score_possible * 0.1) * 100) + "%"
    end

end