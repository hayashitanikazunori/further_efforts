class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :set_post

  def create
    current_user.likes.create(post_id: params[:post_id])
  end

  def destroy
    @like = Like.find_by(
      post_id: params[:post_id],
      user_id: current_user.id
    )
    @like.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
