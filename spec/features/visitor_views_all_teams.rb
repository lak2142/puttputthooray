require 'spec_helper'

feature 'public views all teams' do
  scenario 'visit team index page' do
    college = FactoryGirl.create(:college)
    team_1 = FactoryGirl.create(:team, college: college)
    team_2 = FactoryGirl.create(:team, college: college)
    visit teams_path

    expect(page).to have_content(team_1.team_name)
    expect(page).to have_content(team_2.team_name)
  end

end
