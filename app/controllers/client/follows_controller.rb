class Client::FollowsController < ApplicationController
  before_action :authenticate_client!
  
  def create
    contractor = Contractor.find(params[:contractor_id])
    current_client.follow(contractor)
    redirect_back(fallback_location: root_url)
  end
  
  def destroy
    contractor = Contractor.find(params[:contractor_id])
    current_client.unfollow(contractor)
    redirect_back(fallback_location: root_url)
  end
end
