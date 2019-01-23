class ShopsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :index]
  before_action :login_check, only: [:index, :show] #currentuserじゃなければログイン画面に遷移
  before_action :ensure_correct_user, only: [:edit, :destroy] #useridが一致しなければ編集、削除できない
  
  PER = 8
    
  def index
    @search = Shop.ransack(params[:q]) #ransackメソッド推奨
    @shops = @search.result.page(params[:page]).per(PER) #ページネーションのメソッド    
  end

  def new
    if params[:back]
      @shop = Shop.new(blog_params)
    else
      @shop = Shop.new
    end
  end

  def create
    @shop = Shop.new(blog_params)
    @shop.user_id = current_user.id
    if @shop.save
      redirect_to shops_path,notice:" 新規投稿しました！"
    else
      render'new'
    end
  end

  def show
    @favorite = current_user.favorites.find_by(shop_id: @shop.id)
  end

  def edit
  end

  def destroy
    @shop.destroy
    redirect_to shops_path, notice:"削除しました！"
  end

  def confirm
    @shop = Shop.new(blog_params)
    @shop.user_id = current_user.id
    render :new if @shop.invalid?
  end

  def update
    if @shop.update(blog_params)
      redirect_to shops_path, notice:"編集しました！"
    else
      render'edit'
    end
  end 

  def favorite
    @user = User.find(params[:id])
    @favorites_shops = @user.favorites
  end

  private

  def blog_params
    params.require(:shop).permit(:shop_name, :address, :visitdate, :shop_image, :shop_image_cache, :bread_name1,
      :bread_image1, :bread_image1_cache, :bread_name2, :bread_image2, :bread_image2_cache, :bread_name3, :bread_image3,
      :bread_image3_cache)
  end
  
  def set_blog
    @shop = Shop.find(params[:id])
  end 

  def ensure_correct_user
    @shop = Shop.find_by(id:params[:id])
    if @shop.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to shops_path
    end
  end
end
