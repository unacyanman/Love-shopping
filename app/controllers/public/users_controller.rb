class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :authorize_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to edit_public_user_path(@user)
    else
      flash.now[:error] = "名前を入力してください"
      render 'edit'
    end
  end
  
  def get_profile_image
    # 画像の取得処理を実装する
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_users_path, notice: '退会しました。'
  end
  
  private

  def authorize_user
    if current_user != User.find(params[:id])
      redirect_to mypage_path, alert: "他のユーザーの編集はできません。"
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  
end
