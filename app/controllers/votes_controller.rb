class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      p "success"
      redirect_to :root
    else
      p "failure"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:game_id, :voter_id, :team_id)
  end

end
