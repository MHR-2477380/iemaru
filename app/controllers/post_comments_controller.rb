class PostCommentsController < ApplicationController

    before_action :authenticate_user!

    def create
        @article = Article.find(params[:article_id])
        @post_comment = current_user.post_comments.new(post_comment_params)
        @post_comment.article_id = @article.id

        if @post_comment.save
           # 新規コメント投稿フォームにレンダーするために必要なインスタンス
           @new_post_comment = PostComment.new
        else
           flash[:notice] = "入力されていない項目があります。"
           redirect_back(fallback_location:root_path)
        end
    end

    def edit
        @article = Article.find(params[:article_id])
        @post_comment = PostComment.find(params[:id])

        if  @post_comment.user_id != current_user.id
            flash[:notice] = "権限がありません。"
            redirect_to article_path(@article)
        end
    end

    def update
        @post_comment = PostComment.find(params[:id])

        if  @post_comment.update(post_comment_params)
            flash[:notice] = "コメントを編集しました。"
            redirect_to article_path(@post_comment.article.id)
        else
            flash[:notice] = "入力されていない項目があります。"
            redirect_back(fallback_location:root_path)
        end
    end

    def destroy
        @post_comment = PostComment.find(params[:id])
        @post_comment.destroy
        # articleの詳細ページにレンダーするために必要なインスタンス
        @article = Article.find(params[:article_id])
    end

end

private

def post_comment_params
    params.require(:post_comment).permit(:comment, :post_comment_image)
end