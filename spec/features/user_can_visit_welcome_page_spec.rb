require 'rails_helper'

describe "user can visit the welcome page", type: :view do
  scenario "and see a dropdown menu" do
    visit '/'
    expect(page).to have_content("Nearest Fuel Station")
    expect(page).to have_content("Search For The Nearest Electric Charging Station")
    expect(page).to have_button("Find Nearest Station")
  end

  scenario "select Turing from drop down and click Find Nearest Station" do
    visit '/'

    select "Turing"

    click_on "Find Nearest Station"

    expect(current_path).to eq("/search")

    expect(page).to have_content("16M BUILDING 16M B-1")
    expect(page).to have_content("1550 Market St,Denver,CO,80202")
    expect(page).to have_content("ELEC")
    expect(page).to have_content("24 hours daily")
    expect(page).to have_content("0.1 miles") 
    expect(page).to have_content("1 min")
    directions = "Start out going southeast on 17th St toward Larimer St/CO-33. Turn right onto Larimer St/CO-33. Turn right onto 15th St/CO-33. Turn right onto Market St. 1550 MARKET ST is on the right."
    expect(page).to have_content(directions)
  end
end
