class CommentsController < ApplicationController
    def create
     @post = Post.find(params[:post_id])
     @comment = Comment.new(comment_params)
     if current_client
       @comment.user = current_client
     else
       @comment.user = current_contractor
     end
     @comment.post_id = @post.id
     if @comment.save
       redirect_to post_path(@post.id) ,notice: "Comment created!!"
     else
       redirect_to post_path(@post.id) ,notice: "Comment failed…"
     end
    end

    def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
    end

    private
    def comment_params
    params.require(:comment).permit(:content)
    end
end