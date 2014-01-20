class AddRecognitionToTeam < ActiveRecord::Migration
  def up
    add_column :teams, :recognition, :text
  end

  def down
    remove_column :teams, :recognition
  end
end
