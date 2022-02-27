class StationService
  def self.conn
    Faraday.new(url: "https://developer.nrel.gov")
  end

  def self.get_nearest_station(address_string)
    response = conn.get("/api/alt-fuel-stations/v1/nearest.json?location=#{address_string}&api_key=#{ENV["station_api_key"]}")
    # response = conn.get("/v3/businesses/search?location=#{city}&term=#{search}&limit=15&sort_by=distance")

    data = JSON.parse(response.body, symbolize_names: true)
  end
end
