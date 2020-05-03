class QuestionsController < ApplicationController

    before_action :authenticate_user!

    def index
        # ランキング機能
        @ranks = Question.find(Sympathize.group(:question_id).order('count(question_id) desc').limit(3).pluck(:question_id))
        # 一覧表示機能
        @active_questions = Question.where(status: true).page(params[:page]).reverse_order.per(5)
        @passive_questions = Question.where(status: false).page(params[:page]).reverse_order.per(5)
        # カテゴリー検索機能
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

    def show
        @question = Question.find(params[:id])
        # 回答を投稿するためのインスタンス変数
        @answer = Answer.new
    end

    def new
        @question = Question.new
        @user = current_user
    end

    def create
        @question = Question.new(question_params)
        @question.user_id = current_user.id

        if  @question.save
            flash[:notice] = "質問を投稿しました。"
            redirect_to question_path(@question)
        else
            flash[:notice] = "入力されていない項目があるか、字数制限を超過しています。"
            @question = Question.new
            @user = current_user
            render(:new)
        end
    end

    def edit
        @question = Question.find(params[:id])

        if  @question.user_id != current_user.id
            flash[:notice] = "権限がありません。"
            redirect_to question_path(@question)
        end
    end

    def update
        @question = Question.find(params[:id])

        if @question.update(question_params)
           flash[:notice] = "質問を編集しました。"
           redirect_to question_path(@question)
        else
            flash[:notice] = "未入力の項目があります。"
            render(:edit)
        end
    end

    def destroy
        @question = Question.find(params[:id])
        @question.destroy
        redirect_to questions_path
    end

end

private

    def question_params
        params.require(:question).permit(:category_id, :status, :title, :content, :best_answer_id)
    end