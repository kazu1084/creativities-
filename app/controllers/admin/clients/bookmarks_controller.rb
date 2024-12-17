class Admin::Clients::BookmarksController < ApplicationController

  layout 'admin'
  before_action :authenticate_admin!

  def index
    @client = Client.find(params[:client_id])
    @bookmarks = @client.bookmarks
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    flash[:notice] = "success"
    redirect_to admin_client_bookmarks_path
  end
end