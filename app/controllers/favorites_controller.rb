class FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: post)
    authorize favorite

    if favorite.save
      flash[:notice] = "This post has been favorited"
      redirect_to [post.topic, post]
    else
      flash[:error] = "There was a problem favoriting this post. Please try again later"
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])
    authorize favorite

    if favorite.destroy
      flash[:notice] = "This post has been unfavorited"
      redirect_to [post.topic, post]
    else
      flash[:error] = "There was a problem unfavoriting the post. Please try again"
    end
  end
end