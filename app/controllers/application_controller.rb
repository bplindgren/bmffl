class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def session_viewer
    session
  end

  def headtohead
    @result = nil
    render "headtohead"
  end

  def headtoheadresult
    p params
    # @owner1 = Owner.find(params[:owner_1])
    # @owner2 = Owner.find(params[:owner_2])
    # @games = []
    # @tally = { :owner1 => 0, :owner2 => 0, :ties => 0 }
    # Game.all.each do |game|
    #   if game.home_team_owner == @owner1 && game.away_team_owner == @owner2 || game.home_team_owner == @owner2 && game.away_team_owner == @owner1
    #     @games.push(game)
    #     if game.winner
    #       game.winner.owner.id == @owner1.id ? @tally[:owner1] += 1 : @tally[:owner2] += 1
    #     else
    #       @tally[:ties] += 1
    #     end
    #   end
    # end
    # render "headtohead"
  end

  def contact
    render "contact"
  end

end
