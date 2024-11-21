class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.client_id = current_client.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render:new
    end
  end

  def index
    @posts = Post.all
    @posts = @posts.where('title LIKE ?', "%#{params[:keyword]}%").or(
             @posts.where('body LIKE ?', "%#{params[:keyword]}%"))
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    if current_client
      @bookmark = @post.bookmarks.find_by(user: current_client)
    else
      @bookmark = @post.bookmarks.find_by(user: current_contractor)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

private
def post_params
  params.require(:post).permit(:title, :body, :image, :video, :embed_url)
end

end
