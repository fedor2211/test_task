class CreateUserSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :user_skills do |t|
      t.timestamps
    end
  end
end
