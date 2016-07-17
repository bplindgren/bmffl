class SessionController < ApplicationController
  def new
    render "login"
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to :root
    else
      render "new"
    end
  end

  def logout
    session.clear
    redirect_to root_path
  end
end
