class College < ActiveRecord::Base
  resourcify
  has_many :teams,
  inverse_of: :college
end

