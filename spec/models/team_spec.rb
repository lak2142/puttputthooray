require 'spec_helper'

describe Team do
  it { should belong_to :college }

  it { should have_many :users }

  it { should have_valid(:team_name).when('Team Name') }
  it { should_not have_valid(:team_name).when(nil, '') }

  it { should validate_presence_of :college }

  describe '.incomplete?' do

  end
end
