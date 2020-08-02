class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :edit, :destroy, :update, :create]
  before_action :current_user_authenticate, only: [:edit, :destroy, :update]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(6).order('id DESC')
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.span = params[:time]["post_span(4i)"].to_i * 60 + params[:time]["post_span(5i)"].to_i # ここの修正が必要か？
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: '投稿しました'
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    @post.span = params[:time]["post_span(4i)"].to_i * 60 + params[:time]["post_span(5i)"].to_i
    if @post.save
      redirect_to post_path(@post), notice: '編集しました'
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, notice: '削除しました'
    else
      flash.now[:alert] = "削除に失敗しました"
      render :show
    end
  end

  private
  
  def post_params
    params.require(:post).permit(:kind, :body)
  end

  def current_user_authenticate
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      redirect_to posts_path, notice: '権限がありません'
    end
  end
end
