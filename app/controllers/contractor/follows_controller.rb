class Contractor::FollowsController < ApplicationController
  before_action :authenticate_contractor!
  
  def create
    client = Client.find(params[:client_id])
    current_contractor.follow(client)
    redirect_back(fallback_location: root_url)
  end
  
  def destroy
    client = Client.find(params[:client_id])
    current_contractor.unfollow(client)
    redirect_back(fallback_location: root_url)
  end
end
