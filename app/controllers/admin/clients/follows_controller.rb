class Admin::Clients::FollowsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @client = Client.find(params[:client_id])
    @follows = @client.contractors
    @follows = @client.contractors.where('name LIKE ?', "%#{params[:keyword]}%")
  end

  def destroy
    @client = Client.find(params[:client_id])
    @client.unfollow(contractor)
    flash[:notice] = "success"
    redirect_to admin_client_follows_path
  end
end