class OwnersController < ApplicationController
  def index
    @owners = Owner.all
  end

  def show
    @owner = Owner.find(params[:id])
    @stats = @owner.owner_stats("All")
    @teams = @owner.teams
  end
end
