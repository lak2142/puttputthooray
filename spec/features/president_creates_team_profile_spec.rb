require 'spec_helper'

feature "Team pres creates team profile" do

  scenario "pres logs in when team profile and personal profile is not created" do
    college = FactoryGirl.create(:college)
    team = FactoryGirl.create(:team)
    team.college = college
    user = FactoryGirl.create(:user)
    user.team = team
    user.add_role RoleType.PRESIDENT.code
    sign_in_as(user)

    expect(page).to have_content("Profile")

    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Birthdate", with: user.birthdate
    select user.gender, from: "Gender"
    fill_in "University", with: user.university
    select user.graduation_year, from: "Graduation Year"
    fill_in "Hometown", with: user.hometown
    fill_in "Major", with: user.major
    fill_in "Phone", with: user.phone

    click_on "Save Profile"

    expect(page).to have_content("Your profile was created successfully")

    expect(page).to have_content("Edit Team")

    fill_in "Team Name", with: team.team_name

    click_on "Submit"

    expect(page).to have_content("Your team was successfully edited")
    expect(page).to have_content("Add players")
  end

  scenario 'pres logs in when team profile and personal profile are both created'

end
