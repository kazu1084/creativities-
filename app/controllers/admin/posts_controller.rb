class Admin::PostsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "success"
    redirect_to admin_client_path(@post.client_id)
  end

end