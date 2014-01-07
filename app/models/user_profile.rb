ass UserProfile < ActiveRecord::Base
  mount_uploader :avatar, UserProfileUploader
  belongs_to :user
  validates_presence_of :first_name, :last_name, :gender, :university, :graduation_year, :hometown, :major, :birthdate
end

