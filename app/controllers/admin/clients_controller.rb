class Admin::ClientsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @clients = Client.all
  end
  
  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    flash[:notice] = "success"
    redirect_to admin_clients_path
  end
end
