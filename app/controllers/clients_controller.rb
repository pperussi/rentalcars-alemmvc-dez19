class ClientsController < ApplicationController
 before_action :authenticate_user!
 before_action :authorize_admin
 
 def new
    @client = Client.new
    @client.build_address
 end
end
