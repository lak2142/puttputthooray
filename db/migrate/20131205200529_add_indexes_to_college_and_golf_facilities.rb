class AddIndexesToCollegeAndGolfFacilities < ActiveRecord::Migration
  def change
    add_index :colleges, :name
  end
end
