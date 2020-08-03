class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :edit, :destroy, :update, :create]
  before_action :current_user_authenticate, only: [:edit, :destroy, :update]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(6).order('id DESC')
  end

  def show
    @comments = @post.comments.includes(:user)
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.learned_time = params[:time]["post_learned_time(4i)"].to_i * 60 + params[:time]["post_learned_time(5i)"].to_i
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: '投稿しました'
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    @post.update(post_params)
    # あとでモデルに移す
    @post.learned_time = params[:time]["post_learned_time(4i)"].to_i * 60 + params[:time]["post_learned_time(5i)"].to_i
    if @post.save
      redirect_to post_path(@post), notice: '編集しました'
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: '削除しました'
    else
      flash.now[:alert] = "削除に失敗しました"
      render :show
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:learning_language, :memo)
  end

  def current_user_authenticate
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      redirect_to posts_path, notice: '権限がありません'
    end
  end
end
