class ReviewsController < ApplicationController






  def review_params
    params.require(:review).permit(:score, :body,).merge(
      user_id: current_user.id, item_id: params[:item_id]
    )
  end
end
