class ClientsController < ApplicationController

  def mypage
    if current_contractor
      redirect_to root_path, alert: "アクセスできません"
    elsif current_client
      @client = Client.find(params[:client_id])
      if @client.id != current_client.id
        redirect_to root_path, alert: "アクセスできません"
      else
      @posts = @client.posts
      end
    else
      redirect_to root_path, alert: "ログインが必要です"
    end
  end

  def show
    @client = Client.find(params[:id])
    @posts = @client.posts
  end

  def edit
    is_matching_login_client
  end

  def update
    @client = Client.find(params[:id])
    if @client.id == current_client.id
       @client.update(client_params)
       redirect_to client_mypage_path(@client.id)
    end
  end

  def destroy
    is_matching_login_client
    @client = Client.find(params[:id])
  end

  def follows
    is_matching_login_client
    @contractors = @client.contractors
  end

  private
  def client_params
    params.require(:client).permit(:name, :profile_image, :area, :introduction, :purpose, :goal)
  end

  def is_matching_login_client
    if current_contractor
      redirect_to root_path, alert: "アクセスできません"
    elsif current_client
      @client = Client.find(params[:id])
      if @client.id != current_client.id
        redirect_to root_path, alert: "アクセスできません"
      else
      end
    else
      redirect_to root_path, alert: "ログインが必要です"
    end
  end
end
