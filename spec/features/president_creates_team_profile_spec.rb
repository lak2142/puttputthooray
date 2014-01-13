require 'spec_helper'

feature "Team pres creates team profile" do

  scenario "pres inputs valid information" do

    visit accept_user_invitation_path
    5a50e9e0975f29d83432c15ac23f24502ee1a959fe3d953c77cecedb38bc68d0

    fill_in "Password", with: "password", match: :prefer_exact
    save_and_open_page
    fill_in "Password confirmation", with: "password", match: :prefer_exact

    click_on "Submit"

    expect(page).to have_content("Please fill out your profile.")
  end

  scenario 'pres inputs invalid information'

end
