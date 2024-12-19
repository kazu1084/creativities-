class Admin::Clients::ReviewsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @client = Client.find(params[:client_id])
    @reviews = @client.reviews
    @contractors = @reviews.map(&:contractor).uniq
    @reviews = @client.reviews.where('name LIKE ?', "%#{params[:keyword]}%").or(@client.reviews.where(' body LIKE ?', "%#{params[:keyword]}%"))
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    flash[:notice] = "success"
    redirect_to admin_client_reviews_path
  end
end