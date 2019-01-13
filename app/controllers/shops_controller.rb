class ShopsController < ApplicationController
    before_action :set_blog, only: [:show, :edit, :update, :destroy]
    #before_action :require_login, only:[:edit, :destroy, :show, :new, :index]
    before_action :authenticate_user!, only: [:new, :edit, :update, :destroy,:index]
    def index
        @shops = Shop.all
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
        params.require(:shop).permit(:title, :content,:shop_image,:shop_image_cache,:bread_image1,:bread_image1_cache,:bread_image2,:bread_image2_cache,:bread_image3,:bread_image3_cache)
    end

    def set_blog
        @shop = Shop.find(params[:id])
    end 

    #def require_login
        #unless logged_in?
           # redirect_to new_session_path,notice:"ログインしてください"
       # end
    #end
end
