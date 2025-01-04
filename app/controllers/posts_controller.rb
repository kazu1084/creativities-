class PostsController < ApplicationController
  def new
    unless current_client
      redirect_back(fallback_location: root_url)
    end
    @post = Post.new
  end

  def create
    unless current_client
      redirect_to root_path
    end
    @post = Post.new(post_params)
    @post.client_id = current_client.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "投稿できませんでした。"
      render:new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
    @posts = @posts.where('title LIKE ?', "%#{params[:keyword]}%").or(
             @posts.where('body LIKE ?', "%#{params[:keyword]}%"))
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comment_reply = @post.comments.build
    if current_client
      @bookmark = @post.bookmarks.find_by(user: current_client)
    else
      @bookmark = @post.bookmarks.find_by(user: current_contractor)
    end
  end

  def edit
    @post = Post.find(params[:id])
    access_limit_client
  end

  def update
    @post = Post.find(params[:id])
    access_limit_client
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    access_limit_client
    @post.destroy
    redirect_to posts_path
  end

private
def post_params
  params.require(:post).permit(:title, :body, :image, :video, :embed_url)
end

  def access_limit_client
    if current_contractor
      redirect_to posts_path, alert: "アクセスできません"
    elsif current_client
      if @post.client_id != current_client.id
        redirect_to posts_path, alert: "アクセスできません"
      else
      end
    else
      redirect_to root_path, alert: "ログインが必要です"
    end
  end

end
