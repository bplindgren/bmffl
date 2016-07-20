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
    @owner1 = Owner.find(params[:owner_1])
    @owner2 = Owner.find(params[:owner_2])
    @games = []
    Game.all.each do |game|
      if game.home_team_owner == @owner1 && game.away_team_owner == @owner2 || game.home_team_owner == @owner2 && game.away_team_owner == @owner1
        @games.push(game)
      end
    end
    render "headtohead"
  end

  def contact
    render "contact"
  end

end
