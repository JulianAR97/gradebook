class CreateUserSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :user_subjects do |t|
      t.integer :user_id
      t.integer :subject_id
    end
  end
end
