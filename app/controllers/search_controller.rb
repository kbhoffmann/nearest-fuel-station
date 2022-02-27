class SearchController < ApplicationController
  def index
    @station = Facade.nearest_electric_station('')
  end
end
