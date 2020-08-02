class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(params[:post_id]), notice: 'コメントを投稿しました'
    else
      redirect_to post_path(params[:post_id]), alert: 'コメントの投稿に失敗しました'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      flash[:notice] = 'コメントを削除しました。'
      redirect_to post_path(params[:post_id]), notice: 'コメントを削除しました'
    else
      redirect_to post_path(params[:post_id]), alert: '権限がありません'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:review, :post_id)
  end
end
