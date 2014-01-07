class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :university
      t.integer :graduation_year
      t.string :hometown
      t.string :major
      t.string :phone
      t.integer :user_id
      t.date :birthdate
      t.references :user

      t.timestamps
    end
  end
end
