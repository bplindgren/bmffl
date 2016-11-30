class OwnersController < ApplicationController

  def show
    @owner = Owner.find(params["id"])
    @stats = @owner.owner_stats("All")
    @owner_teams = @owner.teams
  end

end
