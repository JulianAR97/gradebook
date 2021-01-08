class Assignment < ActiveRecord::Base
    belongs_to :subject

    # Working, but ugly, fix please
    def self.score_as_percentage(score_earned, score_possible)
        "%.2f" % ((score_earned * 0.1) / (score_possible * 0.1) * 100) + "%"
    end

    def self.f_date_for_sort(date)
        Date.strptime(date, '%m/%d/%Y').strftime('%Y/%m/%d')
    end

    def self.sort_for_table
        all.sort_by { |a| [a[:category], f_date_for_sort(a[:date])] }
    end

    # Only want this called when sorting for table
    private_class_method :f_date_for_sort

end
