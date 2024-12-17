class Admin::ClientsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @clients = Client.all
    @clients = Client.where('name LIKE ?', "%#{params[:name]}%")
  end

  def show
    @client = Client.find(params[:id])
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    flash[:notice] = "success"
    redirect_to admin_clients_path
  end
end
