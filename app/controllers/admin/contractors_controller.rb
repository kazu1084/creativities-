class Admin::ContractorsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @contractors = Contractor.all
  end

  def destroy
    @contractor = Contractor.find(params[:id])
    @contractor.destroy
    flash[:notice] = "success"
    redirect_to admin_contractors_path
  end
end