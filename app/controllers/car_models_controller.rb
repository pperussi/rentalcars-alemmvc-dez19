class CarModelsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @car_models = CarModel.all
  end

  def show
    @car_model = CarModel.find(params[:id])
  end

  def new
    @car_model = CarModel.new
    @manufactures = Manufacture.all
    @fuel_types = FuelType.all
  end

  def create
    @car_model = CarModel.new(car_model_params)
    return redirect_to @car_model if @car_model.save

    @manufactures = Manufacture.all
    @fuel_types = FuelType.all
    render :new
  end

  def edit
    @car_model = CarModel.find(params[:id])
    @manufactures = Manufacture.all
    @fuel_types = FuelType.all
  end

  def update
    @car_model = CarModel.find(params[:id])
    @manufactures = Manufacture.all
    @fuel_types = FuelType.all
    if @car_model.update(car_model_params)
      redirect_to @car_model
    else
      render :edit
    end
  end

  private
  def car_model_params
    params.require(:car_model).permit(%i[name year manufacture_id motorization
    fuel_type_id category car_options])
  end

end
