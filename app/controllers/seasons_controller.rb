class SeasonsController < ApplicationController

  def show
    @season = Season.find(params[:id])
    @game_type = "All"
    @standings = @season.standings(@game_type, @season.teams)
    @champion = @season.champion
    @division_standings = @season.division_standings(@game_type)
  end

end
