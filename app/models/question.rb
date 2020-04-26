class Question < ApplicationRecord

	has_many :answers, dependent: :destroy
	has_many :sympathizes, dependent: :destroy

	belongs_to :user
	belongs_to :category

	validates :title, presence: true, length: { maximum: 40 }

	attachment :question_image

	def sympathized_by?(user)
		sympathizes.where(user_id: user.id).exists?
	end

end