class CreateAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :assignments do |t|
      t.string :category # test, project, homework
      t.integer :score_earned
      t.integer :score_possible
      t.integer :subject_id
      t.string :date
    end
  end
end

