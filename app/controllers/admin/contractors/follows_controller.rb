class Admin::Contractors::FollowsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @contractor = Contractor.find(params[:contractor_id])
    @follows = @contractor.clients
    @follows = @contractor.clients.where('name LIKE ?', "%#{params[:keyword]}%")
  end

  def destroy
    @contractor = Contractor.find(params[:contractor_id])
    client = Client.find(params[:id])
    @contractor.unfollow(client)
    flash[:notice] = "success"
    redirect_to admin_contractor_follows_path
  end
end