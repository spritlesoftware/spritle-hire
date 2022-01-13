class QuestionsController < ApplicationController
  protect_from_forgery :except => [:submit_answer]

  def index
    @questions = []

    @test = Result.get_test_result(current_user.id, current_user.current_sign_in_at)
    tags = JSON.parse Test.first.tags
    @test_config = Test.first

    tags.each do |tag|
      @questions += Question.where(tag: tag["question_tag"]).limit(tag["count"]).order("RANDOM()")
    end
  end

  def submit_answer
    Result.where(user_id: current_user.id).update({ marks_get: params[:correct_answers], total_marks: params[:total_questions], percentage: params[:percentage] })
    User.where(id: current_user.id).update(took_test: true)
  end
end
