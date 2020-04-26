class Bookmark < ApplicationRecord

  belongs_to :user
  belongs_to :article

  validates :user_id, uniqueness: { scope: :article_id } # 1人のユーザーが同じ投稿を複数回bookmarkできないようにする


end
