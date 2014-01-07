class AddCourseOwnerToRoleType < ActiveRecord::Migration
  def change
    RoleType.create(code: "CO", description: "Course Owner")
  end
end
