class CreateRoleTypes < ActiveRecord::Migration
  def change
    create_table :role_types do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
    RoleType.create(:code => "SUPER", :description => "Super Admin")
    RoleType.create(:code => "ADMIN", :description => "Admin")
    RoleType.create(:code => "RC", :description => "Regional Coordinator")
    RoleType.create(:code => "PRESIDENT", :description => "Club Team President")
    RoleType.create(:code => "MEMBER", :description => "Member")
  end
end
