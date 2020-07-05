class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  # ここでエラーが起こっている
  def ranking
    today = Date.current

    @rank_user = User.find( 
      Post.group(:user_id) # user_idでグループ化
      .where(created_at: today.in_time_zone.all_week) # 今週の投稿のみで絞り込み
      .order("sum(:span) desc") # spanカラムを合計してそれを降順に並び替える
      .limit(10) # 10番目まで取得
      .pluck(:user_id) # 最後にuser_idを返す
    )
  end
end
