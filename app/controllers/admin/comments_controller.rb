class Admin::CommentsController < ApplicationController
  
  before_action :find_comment, only: [:destroy]
  before_action :load_comments, only: [:index]

  def destroy
    @comment.destroy
    redirect_to admin_dashboards_path, notice: 'コメントを削除しました'
  end

  def index
    # すべてのコメントを取得して@commentsに代入
    @comments = Comment.all
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end
  
  def load_comments
    @comments = Comment.all
  end
  
end
