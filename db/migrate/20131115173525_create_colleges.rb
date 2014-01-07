class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
      t.string :name, null: false
      t.string :address
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.string :website
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
