require 'spec_helper'

feature "Team pres removes player" do
  let(:college) { FactoryGirl.create(:college) }
  let(:team) {  FactoryGirl.create(:team) }
  let(:president) { FactoryGirl.create(:user)}
  let!(:player1) { FactoryGirl.create(:user, team: team)}


  before(:each) do
    team.college = college
    president.team = team
    president.add_role RoleType.PRESIDENT.code
    user_profile = FactoryGirl.create(:user_profile, user: president)
    president.save
    sign_in_as(president)
    visit team_path(team)
  end


  scenario "pres removes player" do
    expect(page).to have_content(player1.email)
    save_and_open_page
    within "##{player1.id}" do
    click_on "remove member" 
  end
    expect(page).to_not have_content(player1.email)

  end

end