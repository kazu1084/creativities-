class Admin::ContractorsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @contractors = Contractor.all
    @contractors = Contractor.where('name LIKE ?', "%#{params[:name]}%")
  end

  def show
    @contractor = Contractor.find(params[:id])
  end

  def destroy
    @contractor = Contractor.find(params[:id])
    @contractor.destroy
    flash[:notice] = "success"
    redirect_to admin_contractors_path
  end
end
