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
      @comment = Comment.find(params[:id])
      if current_client
        if @comment.user.id == current_client.id
           @comment.destroy
           redirect_to post_path(@comment.post_id)
        else
           redirect_to post_path(@comment.post_id)
        end
      end
      if current_contractor
        if @comment.user.id == current_contractor.id
           @comment.destroy
           redirect_to post_path(@comment.post_id)
        else
           redirect_to post_path(@comment.post_id)
        end
      end
    end

    private
      def comment_params
      params.require(:comment).permit(:content)
      end
end