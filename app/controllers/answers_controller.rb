class AnswersController < ApplicationController


    before_action :authenticate_user!


    def create
        @question = Question.find(params[:question_id])
        @answer = current_user.answers.new(answer_params)
        @answer.question_id = @question.id
        if  @answer.saveflash[:notice] = "回答を投稿しました。"
            redirect_to question_path(@answer.question.id)
        else
            flash[:notice] = "入力されていない項目があります。"
            redirect_back(fallback_location:root_path)
        end
    end


    def edit
        @question = Question.find(params[:question_id])
        @answer = Answer.find(params[:id])

        if  @answer.user_id != current_user.id
            flash[:notice] = "権限がありません。"
            redirect_to question_path(@question)
        end
    end


    def update
        @answer = Answer.find(params[:id])

        if  @answer.update(answer_params)
            flash[:notice] = "回答を編集しました。"
            redirect_to question_path(@answer.question.id)
        else
            flash[:notice] = "入力されていない項目があります。"
            redirect_back(fallback_location:root_path)
        end
    end


    def destroy
        @answer = Answer.find(params[:id])
        @answer.destroy
        redirect_back(fallback_location: root_path)
    end


end

private

def answer_params
    params.require(:answer).permit(:content)
end