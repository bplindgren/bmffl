class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @games = @team.games.sort
    @stats = @team.team_stats("All")
  end
end
