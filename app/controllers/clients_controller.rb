class ClientsController < ApplicationController
  def mypage
    @client = Client.find(params[:client_id])
    @posts = @client.posts
  end

  def show
    @client = Client.find(params[:id])
    @posts = @client.posts
  end

  def edit
    is_matching_login_client
    @client = Client.find(params[:id])
  end

  def update
    is_matching_login_client
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

  private
  def client_params
    params.require(:client).permit(:name, :profile_image, :area, :introduction, :purpose, :goal)
  end
end
