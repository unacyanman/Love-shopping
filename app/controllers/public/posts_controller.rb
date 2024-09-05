class Public::PostsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]

  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end
  
  def index
    @posts = Post.page(params[:page])
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    if @post
      @comment = Comment.new
    else
      redirect_to posts_path, notice: '指定された投稿が見つかりませんでした'
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)  
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  
  private
  
  def authenticate_user
    unless current_user
      redirect_to login_path, alert: "ログインしてください"
    end
  end
  
  def authenticate_user
    unless current_user
      redirect_to login_path, alert: "ログインしてください"
    end
  end
  
  def post_params
    params.require(:post).permit(:title, :body)
  end
  
end
