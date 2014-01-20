require 'spec_helper'

feature "Team pres adds team members" do
  let(:college) { FactoryGirl.create(:college) }
  let(:team) {  FactoryGirl.create(:team) }
  let(:president) { FactoryGirl.create(:user)}
  let(:email) { 'newgolfer@mail.com'}

  before(:each) do
    team.college = college
    president.team = team
    president.add_role RoleType.PRESIDENT.code
    president.save
    ActionMailer::Base.deliveries = []
    sign_in_as(president)
    visit team_path(team)
  end

  scenario "pres adds new member to team" do
    fill_in 'email', with: email
    click_on 'Invite Team Member'
    new_member = User.find_by(email: email)
    expect(page).to have_content 'Team member added successfully'
    expect(team.users).to include(new_member)
    invite_email = ActionMailer::Base.deliveries.last
    expect(invite_email.to).to include(email)
  end

  scenario 'pres inputs invalid information' do
    fill_in 'email', with: 'invalid'
    click_on 'Invite Team Member'
    expect(page).to have_content 'Please enter a valid email address'
    expect(page).to have_content team.team_name
    expect(ActionMailer::Base.deliveries).to be_empty
  end

end
