class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  # def destroy
  #   @comment = Comment.find_by(
  #     id: params[:id],
  #     post_id: params[:post_id])
  #     binding.pry
  #   if @comment.destroy
  #     redirect_back(fallback_location: root_path)
  #   else
  #     redirect_back(fallback_location: root_path)
  #   end
  # end

  private
  def comment_params
    params.require(:comment).permit(:review, :post_id)
  end
end
