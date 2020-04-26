class SympathizesController < ApplicationController

	def create
            @question = Question.find(params[:question_id])
            @sympathize = current_user.sympathizes.new(question_id: @question.id)
            @sympathize.save
        end

	def destroy
            @question = Question.find(params[:question_id])
            @sympathize = current_user.sympathizes.find_by(question_id: @question.id)
            @sympathize.destroy
        end


end
