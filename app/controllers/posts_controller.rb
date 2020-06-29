class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def ranking
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params, span: post_span.time)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to "/posts"
    else
      flash.now[:alert] = "投稿に失敗しました"
      render("posts/new")
    end
  end

  def edit
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:kind, :body)
  end

  # 時間を記録する
  def post_span
    hour = params[:post_span(4i)]
    minute = params[:post_span(5i)]
    time = minute + hour * 60
  end
end
