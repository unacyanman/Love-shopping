class Public::PostsController < ApplicationController
  
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
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit()
  end
  
end
