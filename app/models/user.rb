class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :user_type
  after_create :assign_role
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  has_one :user_profile
  has_one :course_owner_profile
  has_many :owner_courses

  belongs_to :team

  def role
    roles.present? ? roles.first.name : RoleType.MEMBER.code
  end

  def role_type_id
    RoleType.where(:code => role).first.id
  end

  def has_super_admin_privilege?
    return false if self.roles.empty?
    self.has_role? RoleType.SUPER.code
  end

  def has_admin_privilege?
    return false if self.roles.empty?
    [RoleType.SUPER.code, RoleType.ADMIN.code].include? self.roles.first.name
  end

  def has_rc_privilege?
    return false if self.roles.empty?
    [RoleType.SUPER.code, RoleType.ADMIN.code, RoleType.RC.code].include? self.roles.first.name
  end

  def has_president_privilege?
    return false if self.roles.empty?
    [RoleType.SUPER.code, RoleType.ADMIN.code, RoleType.RC.code, RoleType.PRESIDENT.code].include? self.roles.first.name
  end

  def is_course_manager?
    roles.present? && roles.first.name == RoleType.CO.code
  end

  def update_role(role_id)
    role_type = RoleType.find_by_id(role_id)
    if self.roles.present?
      self.remove_role self.roles.first.name
    end
    add_role role_type.code
  end

  def profile_complete?
    self.user_profile.present?
  end

  def assign_role
    if self.user_type == "course_owner"
      self.add_role RoleType.CO.code
    end
  end

end

