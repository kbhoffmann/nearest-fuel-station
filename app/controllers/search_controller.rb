class SearchController < ApplicationController
  def index
    searched_address = params[:location]#"1331 17th St, Denver, CO 80202"

    fuel_conn = Faraday.new(url: 'https://developer.nrel.gov')
    fuel_api_response = fuel_conn.get('/api/alt-fuel-stations/v1/nearest.json?limit=1') do |request|
      request.params['api_key'] = ENV['station_api_key']
      request.params['location'] = searched_address
    end

    station_data = JSON.parse(fuel_api_response.body, symbolize_names: true)

    fuel_station_details = station_data[:fuel_stations][0]

    @station_name = fuel_station_details[:station_name]
    @fuel_type = fuel_station_details[:fuel_type_code]
    @access_times = fuel_station_details[:access_days_time]
    @distance = fuel_station_details[:distance] #= 0.12268 (float)
    #"0.1 miles"
    street_address = fuel_station_details[:street_address]
    city = fuel_station_details[:city]
    state = fuel_station_details[:state]
    zip = fuel_station_details[:zip]
    @station_address = "#{street_address}" + "," + "#{city}" + "," + "#{state}" + "," + "#{zip}"

    maps_conn = Faraday.new(url: "http://www.mapquestapi.com")
    map_api_response = maps_conn.get("/directions/v2/route") do |request|
      request.params['key'] = ENV['map_api_key']
      request.params['from'] = searched_address
      request.params['to'] = @station_address
    end

    directions_data = JSON.parse(map_api_response.body, symbolize_names: true)
    @travel_time = directions_data[:route][:legs][0][:time] #=60(ingteger) seconds

    @directions = []
    directions_data[:route][:legs][0][:maneuvers].each do |maneuver|
                    @directions << maneuver[:narrative]
                  end
  end
end
