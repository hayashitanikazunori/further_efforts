class FollowRelationshipsController < ApplicationController
  def create
    @user = User.find(params[:follow_relationship][:following_id])
    current_user.follow(@user)
    redirect_to user_path(@user), notice: 'フォローしました'
  end

  def destroy
    @user = User.find(params[:follow_relationship][:following_id])
    current_user.unfollow(@user)
    redirect_to user_path(@user), notice: 'フォローを解除しました'
  end
end
