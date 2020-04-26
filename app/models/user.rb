class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :sympathizes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # ブックマーク機能のアソシエーション
  has_many :bookmarks, dependent: :destroy
  # ユーザーがブックマークした投稿を直接アソシエーションで取得できるように"bookmark_articles"を定義
  has_many :bookmark_articles, through: :bookmarks, source: :article


  validates :name, presence: true, length: { maximum: 10 }

  attachment :profile_image

end
