class BowerytimesController < ApplicationController
  def index
    @volumes = Bowerytimes.all
  end
end
