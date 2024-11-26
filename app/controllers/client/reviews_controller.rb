class Client::ReviewsController < ApplicationController
def new
  @contractor = Contractor.find(params[:contractor_id])
  @review = Review.new
end

def create
  @contractor = Contractor.find(params[:contractor_id])
  @review = Review.new(review_params)
  @review.client_id = current_client.id
  if @review.save
     redirect_to contractor_path(@contractor)
  else
    render:new
    flash[:notice] = "Reviewが送信できませんでした。"
  end
end


private

  def review_params
    params.require(:review).permit(:score, :body).merge(
    client_id: current_client.id,
    contractor_id: @contractor.id)
  end
end
