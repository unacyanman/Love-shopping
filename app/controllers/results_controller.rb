class ResultsController < ApplicationController
  
  def index
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    render locals: { posts: @posts }
    @posts = Post.page(params[:page])
    @posts = Post.includes(:user).page(params[:page])
  end
  
end
