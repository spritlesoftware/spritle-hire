class Admin::TestsController < ApplicationController
  before_action :set_test, only: [ :edit, :update, :destroy ]

  def index
    @tests = Test.all.order(created_at: :desc)
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)

    respond_to do |format|
      if @test.save
        # email_notification(@test)

        format.html { redirect_to tests_path, notice: 'Test was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to tests_path, notice: 'Test was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @test.destroy

    respond_to do |format|
      format.html { redirect_to tests_path, notice: 'Test was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def test_params
      params.require(:test).permit(:name, :total_time, :tags, :status)
    end
end
