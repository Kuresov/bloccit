class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(params.require(:comment).permit(:body))
    @comment.post = @post
    authorize @comment

    if @comment.save
      flash[:notice] = "Comment saved!"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = @comment.errors.full_messages.to_sentence
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment removed."
    else
      flash[:error] = "There was an error removing your comment. Please try again."
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
