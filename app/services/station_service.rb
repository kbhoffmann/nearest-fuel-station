class StationService
  def self.conn
    Faraday.new(url: "https://developer.nrel.gov")
  end

  def self.get_nearest_station(searched_address)
    response = conn.get("/api/alt-fuel-stations/v1/nearest.json?location=#{searched_address}&api_key=#{ENV["station_api_key"]}")
    # response = conn.get("/v3/businesses/search?location=#{city}&term=#{search}&limit=15&sort_by=distance")

    data = JSON.parse(response.body, symbolize_names: true)
  end
end
