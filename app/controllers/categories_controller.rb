class CategoriesController < ApplicationController

	before_action :authenticate_user!

	def index

		@categories = Category.all

		if params[:category_id].present?
			# params[:category_id]が存在する場合、カテゴリーに紐づく質問のみを取得する
			@category = Category.find(params[:category_id].to_i)
			@questions = Question.where(category_id: @category.id)
		else
			# params[:category_id]が存在しない場合、質問を全て取得する
			@questions = Question.all
		end
	end


end