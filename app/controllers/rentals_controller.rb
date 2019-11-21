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
    category = Category.find(params['rental']['category_id'])
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
    @rental.update(rental_params)
    byebug
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
    @rental.available_cars.each { |car| @rental.rental_items.build(car: car) }
  end

  private

  def rental_params
    params.require(:rental).permit(:category_id, :client_id, :start_date,
                                   :end_date,
                                   rental_items_attributes: [:car_id])
  end
end
