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
    rental_price = RentalPrice.where(category: category,
                                     subsidiary: subsidiary).last
    @rental.subsidiary = subsidiary
    @rental.rental_price = rental_price
    if @rental.save!
      redirect_to rentals_path
    else
      @clients = Client.all
      @categories = Category.all
      render :new
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:category_id, :client_id, :start_date,
                                   :end_date)
  end
end
