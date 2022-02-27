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
# ["Turing", "1331 17th St, Denver, CO 80202"]
    click_on "Find Nearest Station"

    expect(current_path).to eq("/search")
    # Then I should see the closest electric fuel station to me.
    # For that station I should see
    # expect(page).to have_content(station.name)
    # expect(page).to have_content(station.address)
    # expect(page).to have_content(station.fuel_type)
    # expect(page).to have_content(station.access_times)
  end
end

# I should also see:
# - the distance of the nearest station (should be 0.1 miles)
# - the travel time from Turing to that fuel station (should be 1 min)
# - The direction instructions to get to that fuel station
#   "Turn left onto Lawrence St Destination will be on the left"
