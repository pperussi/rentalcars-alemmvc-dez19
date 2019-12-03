class RentalsController < ApplicationController
  before_action :authorize_user!, only: %i[confirm]

  def index
    @rentals = Rental.where(subsidiary: current_subsidiary)
  end

  def show
    rental = Rental.find(params[:id])
    @rental = RentalPresenter.new(rental).status
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
    if @car = Car.find_by(id: params[:car_id])
      @car.unavailable!
      @rental.rental_items.create(rentable: @car, daily_rate:
                                  @car.category.daily_rate +
                                  @car.category.third_party_insurance +
                                  @car.category.car_insurance)
      if addons = Addon.where(id: params[:addon_ids])
        addon_items = addons.map { |addon| addon.first_available_item }
        addon_items.each do |addon_item|
          addon_item.unavailable!
          @rental.rental_items.create(rentable: addon_item, daily_rate: addon_item.addon.daily_rate)
        end
      end
      render :confirm
    else
      flash[:danger] = "Carro deve ser selecionado"
      @cars = @rental.available_cars
      @addons = Addon.joins(:addon_items).where(addon_items: { status: :available }).group(:id)
      @rental = RentalPresenter.new(@rental)
      render :review
    end
  end

  def show
    rental = Rental.find(params[:id])
    @rental = RentalPresenter.new(rental)
  end

  def search
    rental = Rental.find_by(reservation_code: params[:q])
    redirect_to rental if rental
  end

  def review
    rental = Rental.find(params[:id])
    return redirect_to closure_review_rental_path(rental) if rental.ongoing?

    rental.in_review! if rental.scheduled?
    @cars = rental.available_cars.where(subsidiary: current_subsidiary)
    @addons = Addon.joins(:addon_items)
                    .where(addon_items: { status: :available }).group(:id)
    @rental = RentalPresenter.new(rental)
  end

  def closure_review
    @rental = Rental.find(params[:id])
  end

  def start
    @rental = Rental.find(params[:id])
    @rental.ongoing!
    redirect_to @rental
  end

  def finalize
    @rental = Rental.find(params[:id])
    @rental.finalized!
    @rental.car.pending_inspection!
    @rental.update(amount_charged: @rental.calculate_final_price)
    redirect_to @rental
  end

  private

  def rental_params
    params.require(:rental).permit(:category_id, :client_id, :start_date,
                                   :end_date,
                                   rental_items_attributes: [:car_id])
  end

  def authorize_user!
    @rental = Rental.find(params[:id])
    unless current_user.admin? || @rental.subsidiary == current_subsidiary
      redirect_to @rental
    end
  end
end
