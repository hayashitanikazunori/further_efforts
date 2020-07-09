class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # @week_kind = @user.week_total.group(:kind).select(:kind)
    # @week_span = @user.week_total.group(:kind).select(:span).sum(:span)
  end

  def ranking
    today = Date.current # 今日の日付を取得
    @rank_user = User.find( 
      Post.group(:user_id) # user_idでグループ化
      .where(created_at: today.in_time_zone.all_week) # 今週の投稿のみで絞り込み
      .order("sum(span) desc") # spanカラムを合計してそれを降順に並び替える
      .limit(10) # 10番目まで取得
      .pluck(:user_id) # 最後にuser_idを返す
    )
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end
end
