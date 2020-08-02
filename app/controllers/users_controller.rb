class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :ranking]

  def show
    @user = User.find(params[:id])
  end

  def ranking
    @rank_user = User.rank_user
  end
end
