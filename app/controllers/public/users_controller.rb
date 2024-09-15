class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :authorize_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    render locals: { posts: @posts }
  end
  
  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to edit_public_user_path(@user)
    else
      flash[:error] = "名前を入力してください" unless @user.errors[:name].empty?
      redirect_to edit_public_user_path(@user)
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_user_registration_path, notice: '退会しました。'
  end
    
  private

  def authorize_user
    if current_user != User.find(params[:id])
      redirect_to user_path(current_user), alert: "他のユーザーの編集はできません。"
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
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
