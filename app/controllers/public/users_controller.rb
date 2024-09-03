class Public::UsersController < ApplicationController
  
  
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

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  
end
