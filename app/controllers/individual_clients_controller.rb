class IndividualClientsController < ApplicationController
  before_action :authenticate_user!

 def index
   @individual_clients = IndividualClient.all
 end

  def show
    @individual_client = IndividualClient.find(params[:id])
  end

  def new
    @individual_client = IndividualClient.new
    @individual_client.build_address
  end

  def create
    @individual_client = IndividualClient.new(individual_client_params)
    if @individual_client.save
      redirect_to @individual_client
   else
      render :new
    end
  end

  private

  def individual_client_params
    params.require(:individual_client)
      .permit(:name, :cpf, :email, address_attributes: %i[id street number complement
              neighborhood city state])
  end

end
