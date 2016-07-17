class SeasonsController < ApplicationController

  def show
    @season = Season.find(params[:id])
    @game_type = "All"
    @standings = @season.standings(@game_type, @season.teams)
    @champion = @season.champion
    @division_standings = @season.division_standings(@game_type)

    if request.xhr?
      p request
      # erb :'comments/_question_form', { locals: { selected_question: @selected_question }, layout: false}
    end
  end

end
