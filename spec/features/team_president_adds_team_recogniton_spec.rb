require 'spec_helper'

feature "Team pres adds recognition to team profile" do
    let(:college) { FactoryGirl.create(:college) }
  let(:team) {  FactoryGirl.create(:team) }
  let(:president) { FactoryGirl.create(:user)}

  before(:each) do
    team.college = college
    president.team = team
    president.add_role RoleType.PRESIDENT.code
    president.save
    sign_in_as(president)
    visit edit_team_path(team)
  end

  scenario "pres adds new recognition to team profile" do
    fill_in 'Recognition', with: "some recognition"
    click_on 'Submit'
    expect(team.reload.recognition).to eql('some recognition')
    expect(page).to have_content 'some recognition'

  end    

end  