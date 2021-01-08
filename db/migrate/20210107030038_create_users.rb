class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest

      # How do we seed passwords with password_digest
    end
  end
end
