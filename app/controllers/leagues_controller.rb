class LeaguesController < ApplicationController

  def show
    @league = League.find(params[:id])
    @teams = @league.teams
    @seasons = @league.seasons
  end

end