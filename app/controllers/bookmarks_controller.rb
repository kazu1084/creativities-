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
    current_user = current_client || current_contractor
    unless current_user
      redirect_to root_path, alert: 'ログインが必要です。'
      return
    end
    bookmark = post.bookmarks.new(user: current_user)
    bookmark.save
    bookmark.create_notification_bookmark!(
      visitor: current_user,
      visited: bookmark.post.client
    )
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
