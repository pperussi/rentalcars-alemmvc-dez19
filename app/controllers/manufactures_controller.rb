class ManufacturesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @manufactures = Manufacture.all
  end

  def new
    @manufacture = Manufacture.new
  end

  def create
    @manufacture = Manufacture.new(params.require(:manufacture).permit(:name))
    if @manufacture.save
      redirect_to @manufacture
    else
      render :new
    end
  end

  def show
    @manufacture = Manufacture.find(params[:id])
  end

  def edit
    @manufacture = Manufacture.find(params[:id])
  end

  def update
    @manufacture = Manufacture.find(params[:id])
    if @manufacture.update(params.require(:manufacture).permit(:name))
       redirect_to @manufacture
    else
      render :edit
    end
  end
end
