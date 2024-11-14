class BookmarksController < ApplicationController

  def index
    if current_client
      @user_bookmarks = Bookmark.where(user: current_client)
    else
      @user_bookmarks = Bookmark.where(user: current_contractor)
    end
  end

  def create
    post = Post.find(params[:post_id])
    if current_client
      current_user = current_client
    else
      current_user = current_contractor
    end
    bookmark = post.bookmarks.new(user: current_user)
    bookmark.save
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:post_id])
    if current_client
      current_user = current_client
    else
      current_user = current_contractor
    end
    bookmark = post.bookmarks.find_by(user: current_user)
    bookmark.destroy
    redirect_back(fallback_location: root_path)
  end
end
