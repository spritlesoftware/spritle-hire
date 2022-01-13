class Admin::QuestionsController < ApplicationController
  before_action :set_question, only: [ :edit, :update, :destroy ]

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to "/admin/questions", notice: 'Question was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to "/admin/questions", notice: 'Question was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to "/admin/questions", notice: 'Question was successfully destroyed.' }
    end
  end

  def import
  end

  def bulk_upload
    Question.import(params[:file])

    respond_to do |format|
      format.html { redirect_to "/admin/questions", notice: 'Question was successfully uploaded.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:question_text, :question_type, :options, :correct_answer, :tag)
    end
end
