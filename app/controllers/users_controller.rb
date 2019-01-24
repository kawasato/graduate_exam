class UsersController < ApplicationController
  before_action :login_check, only: [:show]
  before_action :user_mypage, only: [:show]
  
  def show
    @user = User.find(params[:id])
  end

  def favorite
    @user = User.find(params[:id])
    @favorites_shops = @user.favorites
  end

  private

  def user_mypage
    if @current_user.id !=  params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to shops_path
    end
  end
end
