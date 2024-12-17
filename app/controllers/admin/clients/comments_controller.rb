class Admin::Clients::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @client = Client.find(params[:client_id])
    @comments = @client.comments
    @comments = @client.comments.where('content LIKE ?', "%#{params[:keyword]}%")
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:notice] = "success"
    redirect_to admin_client_comments_path
  end
end