class Team < ActiveRecord::Base
  belongs_to :college,
    inverse_of: :teams
  has_many :users,
    inverse_of: :team
  validates_presence_of :team_name
  validates_presence_of :college

  attr_accessor :email

  mount_uploader :test_photo, TeamLogoUploader

  # test this

  def incomplete?
    true
  end
end
