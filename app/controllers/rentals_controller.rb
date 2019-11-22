class RentalsController < ApplicationController
  def index
    @rentals = Rental.where(subsidiary: current_subsidiary)
  end

  def new
    @rental = Rental.new
    @clients = Client.all
    @categories = Category.all
  end

  def create
    @rental = Rental.new(rental_params)
    subsidiary = current_subsidiary
    @rental.subsidiary = subsidiary
    @rental.status = :scheduled
    @rental.price_projection = @rental.calculate_price_projection
    if @rental.save
      redirect_to rental_path(@rental.id)
    else
      @clients = Client.all
      @categories = Category.all
      render :new
    end
  end

  def confirm
    @rental = Rental.find(params[:id])
    car = Car.find(params[:car_id])
    @rental.rental_items.create(rentable: car)
    addons = Addon.find(params[:addon_ids])
    #addon_items = addons.map { |addon| addon.addon_items.first_available }
    #@rental.rental_items.create(rentable: addon_items)
    render :confirm
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def search
    @rental = Rental.find_by(reservation_code: params[:q])
    return redirect_to review_rental_path(@rental) if @rental
  end

  def review
    @rental = Rental.find(params[:id])
    @rental.in_review!
    @cars = @rental.available_cars
    @addons = Addon.all
  end

  private

  def rental_params
    params.require(:rental).permit(:category_id, :client_id, :start_date,
                                   :end_date,
                                   rental_items_attributes: [:car_id])
  end
end
