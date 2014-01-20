class Team < ActiveRecord::Base
  belongs_to :college,
    inverse_of: :teams
  has_many :users,
    inverse_of: :team
  validates_presence_of :team_name
  validates_presence_of :college

  attr_accessor :email

  mount_uploader :team_logo, TeamLogoUploader


  def incomplete?
    # must add atleast one member
    users.length <= 1
  end


  def president?(user)
    user.team == self && user.has_president_privilege?
  end

end
