class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = 'コメントを投稿しました。'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = 'コメントの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find_by(
      id: params[:id],
      post_id: params[:post_id]
    )
    if @comment.user_id == current_user.id
      @comment.destroy
      flash[:notice] = 'コメントを削除しました。'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = '権限がありません。'
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:review, :post_id)
  end
end
