class UsersController < ApplicationController
  def new
    render "new"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to :root
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    render "show"
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
