class FuelTypeController < ApplicationController

  def new
    @fuel_type = FuelType.new
  end

end