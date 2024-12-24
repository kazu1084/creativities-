class Admin::Contractors::BookmarksController < ApplicationController

  layout 'admin'
  before_action :authenticate_admin!

  def index
    @contractor = Client.find(params[:contractor_id])
    @bookmarks = @contractor.bookmarks
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    flash[:notice] = "success"
    redirect_to admin_contractor_bookmarks_path
  end
end