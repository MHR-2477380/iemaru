class SearchesController < ApplicationController

	def search

		word = params[:search_word]

		@records = Article.where(

			"town LIKE? or
			family_makeup LIKE? or
			maker LIKE? or
			sales_form LIKE? or
			modality LIKE? or
			style LIKE? or
			purchase_price LIKE? or
			content LIKE?",
			"%#{word}%",
			"%#{word}%",
			"%#{word}%",
			"%#{word}%",
			"%#{word}%",
			"%#{word}%",
			"%#{word}%",
			"%#{word}%").page(params[:page]).reverse_order.per(9)

	end

end