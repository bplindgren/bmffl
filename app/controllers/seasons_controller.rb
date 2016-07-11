class SeasonsController < ApplicationController

  def index
    @seasons = Season.all
  end

  def show
    @season = Season.find(params[:id])
    @standings = @season.standings("All", @season.teams)
  end

end
