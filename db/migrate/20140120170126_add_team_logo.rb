class AddTeamLogo < ActiveRecord::Migration
  def up
    add_column :teams, :team_logo, :string
  end

  def down
    remove_column :teams, :team_logo
  end
end
