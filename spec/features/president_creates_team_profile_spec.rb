require 'spec_helper'

feature "Team pres creates team profile" do

  scenario "pres logs in when team profile and personal profile is not created" do
    college = FactoryGirl.create(:college)
    team = FactoryGirl.create(:team)
    team.college = college
    user = FactoryGirl.create(:user)
    user.team = team
    user.add_role RoleType.PRESIDENT.code
    user.save
    sign_in_as(user)

    expect(page).to have_content("Profile")

    fill_in "First Name", with: 'bob'
    fill_in "Last Name", with: 'bobson'
    fill_in "Birthdate", with: Time.now - 10.years
    choose "Male"
    fill_in "University", with: "Boston U"
    select "2020", from: "Graduation Year"
    fill_in "Hometown", with: "Bangor"
    fill_in "Major", with: "Basketweaving"
    fill_in "Phone", with: "222-222-2222"

    click_on "Save Profile"

    expect(page).to have_content("Your profile was created successfully")
    visit root_path
    save_and_open_page
    expect(page).to have_content("Edit Team")

    fill_in "Team Name", with: team.team_name

    click_on "Submit"

    expect(page).to have_content("Your team was successfully edited")
    expect(page).to have_content("Add players")
  end

  scenario 'pres logs in when team profile and personal profile are both created'

end