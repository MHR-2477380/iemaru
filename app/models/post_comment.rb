class PostComment < ApplicationRecord

	belongs_to :user
	belongs_to :article

	validates :comment, presence: true

	attachment :post_comment_image


end
