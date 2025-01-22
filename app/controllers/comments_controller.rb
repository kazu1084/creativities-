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
       @post.create_notification_comment!(@comment.user, @comment.id)
       redirect_to post_path(@post.id) ,notice: "コメントを投稿しました"
     else
       redirect_to post_path(@post.id) ,alert: "コメントの投稿に失敗しました"
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
      params.require(:comment).permit(:content, :parent_id,:post_id, :user_id, :user_type)
      end
end