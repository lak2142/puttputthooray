module Seeders
  module RoleTypes
    class << self
      def seed
        RoleType.find_or_create_by(:code => "SUPER", :description => "Super Admin")
        RoleType.find_or_create_by(:code => "ADMIN", :description => "Admin")
        RoleType.find_or_create_by(:code => "RC", :description => "Regional Coordinator")
        RoleType.find_or_create_by(:code => "CO", :description => "Course Owner")
        RoleType.find_or_create_by(:code => "PRESIDENT", :description => "Club Team President")
        RoleType.find_or_create_by(:code => "MEMBER", :description => "Member")
      end
    end
  end
end
