class PlotsController < ApplicationController
  def index
    @plots = Plot.all
    @plants = Plant.all
  end

  def destroy
    plots = Plot.all
    plants = Plant.all

    redirect_to "/plots"
  end
end
