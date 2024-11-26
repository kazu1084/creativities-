class Contractor::ReviewsController < ApplicationController
  def index
    @contractor = Contractor.find(params[:contractor_id])
    @reviews = @contractor.reviews
  end
end
