class CreateUserSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :user_skills do |t|
      t.references :users, foreign_key: true
      t.references :skills, foreign_key: true

      t.timestamps
    end
  end
end
