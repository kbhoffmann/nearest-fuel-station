class MapService
  def self.conn
    Faraday.new(url: "http://www.mapquestapi.com")
  end

  def self.get_map
    response = conn.get("/directions/v2/route")
    # response = conn.post("/directions/v2/routematrix?key=#{ENV['mapquest_key']}&from=#{city}&to=#{address}")

    data = JSON.parse(response.body, symbolize_names: true)
  end
end
