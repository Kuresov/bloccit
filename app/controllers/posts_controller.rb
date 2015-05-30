class PostsController < ApplicationController

  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

    def create
      @topic = Topic.find(params[:topic_id])
      @post = current_user.posts.build(post_params)
      @post.topic = @topic
      authorize @post

      if @post.save #( == true/success )
        flash[:notice] = "Your post has been saved."
        redirect_to [@topic, @post]
      else
        flash[:error] = "There was an error saving your post. Please try again."
        render :new
      end
    end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

    def update
      @topic = Topic.find(params[:topic_id])
      @post = Post.find(params[:id])
      authorize @post
      if @post.update_attributes(post_params)
        flash[:notice] = "Your post has been updated."
        redirect_to [@topic, @post]
      else
        flash[:error] = "There was an error saving the post. Please try again."
        render :edit
      end
    end

  private

  def post_params
    params.require(:post).permit(:title, :body, :featured)
  end
end
