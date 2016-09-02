class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  respond_to :html, :js
  protect_from_forgery with: :null_session

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def headtohead
    @result = nil
    render "headtohead"
  end

  def headtoheadresult
    # if request.xhr?
    respond_to do |format|
      format.js
      format.html { render "headtohead" }
    # else
    #   render "headtohead"
    end
  end

  def alltimestats
    @league_stats = League::ALL_TIME_STATS

    # if request.xhr?
    #   stat = params["stat"].to_sym
    #   @sorted = League.first.sort_all_time_stats(stat, "All")
    #   render :partial => "sorted", :locals => { :table_array => @sorted }, :layout => false
    # end
    respond_to do |format|
      format.js
      format.html { render 'alltimestats' }
    #   format.html { @league_stats = League::ALL_TIME_STATS }
    end
  end

  def contact
    render "contact"
  end

  def session_viewer
    render "session_viewer"
  end

end
