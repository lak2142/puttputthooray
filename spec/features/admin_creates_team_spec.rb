require 'spec_helper'

feature 'admin creates a Team' do
  let(:admin) { FactoryGirl.create(:admin) }
  scenario 'admin creates new team' do
    sign_in_as(admin)
    click_link 'Approve New Team'
    select 'Boston College', from: 'College'
    fill_in 'First name', with: 'John'
    fill_in "Last name", with: 'Watson'
    fill_in 'Email', with: 'john@watson.com'
    click_link 'Submit'
    expect(page).to have_content('Invite sent to john@watson.com')
    expect(page).to have_content('Approve New Team')
  end

  scenario 'admin submits invalid information' do
    visit '/'
    admin_sign_in
    click_link 'Approve New Team'
    click_link 'Submit'
    expect(page).to_not have_content('Invite sent')
    within ".input.new_team_college" do
      expect(page).to have_content "can't be blank"
    end
    within ".input.new_team_first_name" do
      expect(page).to have_content "can't be blank"
    end
    within ".input.new_team_last_name" do
      expect(page).to have_content "can't be blank"
    end
    within ".input.new_team_email" do
      expect(page).to have_content "can't be blank"
    end
  end

end
