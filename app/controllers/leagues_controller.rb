class LeaguesController < ApplicationController

  def show
    @league = League.find(params[:id])
    @teams = @league.teams
    @seasons = @league.seasons
    # @current_season = Season.last
    # @standings = @current_season.standings("All", @teams)
  end

end