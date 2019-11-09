class RentalPricesController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end

  def new
    @subsidiary = Subsidiary.find(params[:id])
    @categories = Category.all
    @rental_prices = []
    @categories.count.times { @rental_prices << RentalPrice.new }
  end

  def create
    @subsidiary = Subsidiary.find(params[:id])
    params['rental_prices'].each do |values|
      @rental_price =  RentalPrice.new(rental_price_params(values))
      @rental_price.subsidiary = @subsidiary
      if !@rental_price.save
        @categories = Category.all
        @rental_prices = []
        @categories.count.times { @rental_prices << RentalPrice.new }
        @messages = @rental_price.errors.full_messages
        return render :new
      end
    end
    redirect_to rental_prices_path
  end

  private

  def rental_price_params(price_params)
    price_params.permit(:daily_rate, :daily_car_insurance,
                        :daily_third_party_insurance,
                        :category_id)
  end
end
