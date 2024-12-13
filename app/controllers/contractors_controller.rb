class ContractorsController < ApplicationController

  def mypage
    if current_client
      redirect_to root_path, alert: "アクセスできません"
    elsif current_contractor
      @contractor = Contractor.find(params[:contractor_id])
      if @contractor.id != current_contractor.id
        redirect_to root_path, alert: "アクセスできません"
      end
    else
      redirect_to root_path, alert: "ログインが必要です"
    end
  end

  def show
    @contractor = Contractor.find(params[:id])
  end

  def edit
    is_matching_login_contractor
  end

  def update
    @contractor = Contractor.find(params[:id])
    if @contractor.id == current_contractor.id
       @contractor.update(contractor_params)
       redirect_to contractor_mypage_path(@contractor.id)
    end
  end

  def destroy
    is_matching_login_contractor
  end

  def follows
    is_matching_login_contractor
    @clients = @contractor.clients
  end

  private
  def contractor_params
    params.require(:contractor).permit(:name, :profile_image, :area, :introduction, :skill, :experience)
  end

  def is_matching_login_contractor
    if current_client
      redirect_to root_path, alert: "アクセスできません"
    elsif current_contractor
      @contractor = Contractor.find(params[:id])
      if @contractor.id != current_contractor.id
        redirect_to root_path, alert: "アクセスできません"
      else
      end
    else
      redirect_to root_path, alert: "ログインが必要です"
    end
  end
end