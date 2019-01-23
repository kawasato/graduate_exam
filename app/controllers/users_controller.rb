class UsersController < ApplicationController
  before_action :login_check, only: [:show]
  before_action :user_mypage, only: [:edit]
  
  def show
    @user = User.find(params[:id])
  end

  def favorite
    @user = User.find(params[:id])
    @favorites_shops = @user.favorites
  end

  private

  def user_mypage
    @user = User.find_by(id:params[:id])
    if user_session!= current_user.id
      flash[:notice] = "権限がありません"
      redirect_to shops_path
    end
  end
end
