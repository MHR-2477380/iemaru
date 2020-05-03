class BookmarksController < ApplicationController

  def create
    @bookmark = current_user.bookmarks.new(article_id: params[:article_id])
    @bookmark.save!

    @article = Article.find(params[:article_id])
  end

  def destroy
    @bookmark = current_user.bookmarks.find_by(article_id: params[:article_id])
    @bookmark.destroy!

    @article = Article.find(params[:article_id])
  end

end
