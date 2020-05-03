class ArticlesController < ApplicationController

    before_action :authenticate_user!

    def index
        # ランキング
        @ranks = Article.find(Favorite.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
        # 一覧表示
        @articles = Article.page(params[:page]).reverse_order.per(8)
        # キーワード検索
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
            "%#{word}%").page(params[:page]).reverse_order.per(4)
    end

    def show
        @article = Article.find(params[:id])
        @post_comment = PostComment.new
    end

    def new
        @article = Article.new
        @user = current_user
    end

    def create
         @article = Article.new(article_params)
         @article.user_id = current_user.id

         if @article.save
            flash[:notice] = "ご投稿ありがとうございました！"
            redirect_to article_path(@article)
        else
            flash[:notice] = "入力されていない項目があるか、字数制限を超過しています。"
            render(:new)
        end
    end

    def edit
        @article = Article.find(params[:id])

        if  @article.user_id != current_user.id
            flash[:notice] = "権限がありません。"
            redirect_to article_path(@article)
        end
    end

    def update
        @article = Article.find(params[:id])

        if  @article.update(article_params)
            flash[:notice] = "購入レポートを編集しました。"
            redirect_to article_path(@article)
        else
            flash[:notice] = "入力されていない項目があります。"
            render(:edit)
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

end

private

    def article_params
        params.require(:article).permit(:town, :family_makeup, :maker, :sales_form, :modality, :style, :purchase_price, :article_image, :content)
    end