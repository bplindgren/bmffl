class LeaguesController < ApplicationController

  def show
    @league = League.find(params[:id])
    @teams = @league.teams
  end

end