class LeaguesController < ApplicationController

  def show
    @league = League.find(params[:id])
    @teams = @league.teams
    @seasons = @league.seasons
    @first_five = Game.where(completed?: false).first(5)
  end

end