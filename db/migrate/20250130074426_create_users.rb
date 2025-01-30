class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :patronymic, null: false
      t.string :email, null: false
      t.integer :age, null: false
      t.string :nationality, null: false
      t.string :country, null: false
      t.integer :gender, null: false

      t.timestamps
    end
  end
end
