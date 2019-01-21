class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def favorite
    @user = User.find(params[:id])
    @favorites_shops = @user.favorites
  end
end
