class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :edit, :destroy, :update, :create]
  before_action :current_user_authenticate, only: [:edit, :destroy, :update]

  def index
    @posts = Post.all.page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.span = params[:time]["post_span(4i)"].to_i * 60 + params[:time]["post_span(5i)"].to_i
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to "/posts"
    else
      flash.now[:alert] = "投稿に失敗しました"
      render("posts/new")
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
      flash[:notice] = "編集しました"
      redirect_to "/posts#{params[:id]}"
    else
      flash.now[:alert] = "編集に失敗しました"
      render("/posts/#{params[:id]}")
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "削除しました"
      redirect_to "/posts"
    else
      flash.now[:alert] = "削除に失敗しました"
      render("posts/#{params[:id]}")
    end
  end

  private
  def post_params
    params.require(:post).permit(:kind, :body)
  end

  def current_user_authenticate
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts")
    end
  end
end
