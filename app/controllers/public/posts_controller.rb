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
    @posts = Post.includes(:user).page(params[:page])
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
    if current_user.id != @post.user_id
      redirect_to posts_path, notice: '他の人の投稿は編集できません'
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      @comment = Comment.new
      render :edit
    end

  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(current_user)
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
  
  def get_profile_image(width, height)
  # プロフィール画像のURLを生成する処理
  image_url = profile_image.variant(resize_to_limit: [width, height])

  # 幅と高さを指定したリサイズ処理
  # resized_image_url = generate_resized_image_url(image_url, width, height)

  # リサイズ後の画像のURLを返す
  # default_image_url = asset_path('default_profile_image.jpg')
    return image_url
  end
  
end
