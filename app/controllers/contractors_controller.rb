class ContractorsController < ApplicationController

  def mypage
    @contractor = Contractor.find(params[:contractor_id])
  end

  def show
    @contractor = Contractor.find(params[:id])
  end

  def edit
    @contractor = Contractor.find(params[:id])
  end

  def update
    @contractor = Contractor.find(params[:id])
    if @contractor.id == current_contractor.id
       @contractor.update(contractor_params)
       redirect_to contractor_mypage_path(@contractor.id)
    end
  end

  def destroy
    is_matching_login_client
    @contractor = Contractor.find(params[:id])
  end

  def follows
    @contractor = Contractor.find(params[:id])
    @clients = @contractor.clients
  end

  private
  def contractor_params
    params.require(:contractor).permit(:name, :profile_image, :area, :introduction, :skill, :experience)
  end
end