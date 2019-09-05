class PricesController < ApplicationController

  def index

  end

  def new
    @price = Price.new()
    @subsidiary = Subsidiary.all
    @category = Category.all
  end

end