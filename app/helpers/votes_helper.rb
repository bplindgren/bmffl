module VotesHelper
  def voted_on?
    vote = Vote.where(game_id: @game.id, voter_id: session[:user_id])
    vote.length > 0
  end
end
