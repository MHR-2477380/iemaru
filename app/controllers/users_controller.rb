class UsersController < ApplicationController


	before_action :authenticate_user!


	def index
		@users = User.all.page(params[:page]).reverse_order.per(10)
	end


	def show
		@user = User.find(params[:id])
		@articles = Article.where(user_id:params[:id])
		@questions = Question.where(user_id:params[:id]).page(params[:page]).reverse_order.per(5)
		@bookmarks = current_user.bookmark_articles.page(params[:page]).reverse_order.per(4)
	end


	def edit
		@user = User.find(params[:id])

		if  @user.id != current_user.id
			flash[:notice] = "権限がありません。"
			redirect_to user_path(@user)
		end
	end


	def update
		@user = User.find(params[:id])

		if  @user.update(user_params)
       		flash[:notice] = "ユーザー情報を更新しました。"
       		redirect_to user_path(@user)
    	else
    		flash[:notice] = "入力されていない項目があります。"
      		render(:edit)
    	end
	end


	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to root_path
	end


end

private

    def user_params
        params.require(:user).permit(:profile_image, :name, :content)
    end