class UsersController < ApplicationController
  def new
    @user = User.new
    render "new"
  end

  def create
    p params
    @user = User.new(user_params)
    p @user
    if @user.save
      session[:user_id] = @user.id
      redirect_to :root
    else
      render "new"
    end
  end

  def show
    @user = User.find(session[:user_id])
    render "show"
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :account_type)
  end
end
