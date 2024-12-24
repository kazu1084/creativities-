class Admin::Contractors::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @contractor = Contractor.find(params[:contractor_id])
    @comments = @contractor.comments
    @comments = @contractor.comments.where('content LIKE ?', "%#{params[:keyword]}%")
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:notice] = "success"
    redirect_to admin_contractor_comments_path
  end
end