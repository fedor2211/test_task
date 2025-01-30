class CreateUserInterests < ActiveRecord::Migration[8.0]
  def change
    create_table :user_interests do |t|
      t.references :users, foreign_key: true
      t.references :interests, foreign_key: true
      t.index [ :user_id, :interest_id ], unique: true

      t.timestamps
    end
  end
end
