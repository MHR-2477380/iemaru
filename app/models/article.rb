class Article < ApplicationRecord

	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :post_comments, dependent: :destroy
	has_many :bookmarks, dependent: :destroy

	# current_userが、対象の投稿に "いいね" または "ブックマーク" をしているか判定するメソッド

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
    end

  	def bookmark_by?(user)
    	bookmarks.where(user_id: user.id).exists?
  	end

  	# ここまで

	validates :town, presence: true, length: { maximum: 40 }
	validates :family_makeup, presence: true, length: { maximum: 40 }
	validates :maker, presence: true, length: { maximum: 40 }
	validates :sales_form, presence: true, length: { maximum: 40 }
	validates :modality, presence: true, length: { maximum: 40 }
	validates :style, presence: true, length: { maximum: 40 }
	validates :purchase_price, presence: true, length: { maximum: 40 }
	validates :content, presence: true

	attachment :article_image


end
