class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :week_ranking]

  def show
    @user = User.find(params[:id])
  end

  def week_ranking
    @week_ranking = User.week_ranking
  end
end
