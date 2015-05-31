class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    authorize @comment
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(params.require(:comment).permit(:body))
    @comment.post = @post
    authorize @comment

    if @comment.save
      flash[:notice] = "Comment saved!"
      redirect_to [@topic, @post]
    else
      flash[:error] = @comment.errors.full_messages.to_sentence
      redirect_to [@topic, @post]
    end
  end
end
