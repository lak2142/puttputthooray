require 'spec_helper'

feature 'admin creates a Team' do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:user_profile) { FactoryGirl.create(:user_profile, user: admin) }
  let!(:college) { FactoryGirl.create(:college, name: 'Boston College')}

  scenario 'admin creates new team' do
    president_email = 'johnthepresident@watson.com'
    ActionMailer::Base.deliveries = []
    sign_in_as(admin)
    visit teams_path
    click_on 'Create New Team'
    select 'Boston College', from: 'College'
    fill_in 'Email', with: president_email
    fill_in 'Team name', with: 'Boston Swingers'
    click_on 'Submit'
    invite = ActionMailer::Base.deliveries.last
    expect(invite.to).to include(president_email)
    user = User.find_by(email: president_email)
    expect(Team.last.users).to include(user)
    expect(user.has_president_privilege?).to be_true
  end

  scenario 'admin submits invalid information' do
    visit '/'
    sign_in_as(admin)
    visit teams_path
    click_on 'Create New Team'
    click_on 'Submit'
    expect(page).to_not have_content('Invite sent')
    expect(page).to have_content('Must provide valid email for President')
    within ".input.team_college" do
      expect(page).to have_content "can't be blank"
    end
    within ".input.team_team_name" do
      expect(page).to have_content "can't be blank"
    end
    within ".input.team_email" do
      expect(page).to have_content "Must provide valid email for President"
    end
  end

end
