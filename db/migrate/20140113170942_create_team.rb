class CreateTeam < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team_name, null: false
      t.integer :college_id, null: false


      t.timestamps
    end
  end
end
