class FollowRelationshipsController < ApplicationController
  def create
    @user = User.find(params[:follow_relationship][:following_id])
    current_user.follow(@user)
    flash[:notice] = "フォローしました。"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = User.find(params[:follow_relationship][:following_id])
    current_user.unfollow(@user)
    flash[:notice] = "フォローを解除しました。"
    redirect_back(fallback_location: root_path)
  end
end
