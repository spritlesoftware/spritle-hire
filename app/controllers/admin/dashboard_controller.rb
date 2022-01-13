class Admin::DashboardController < ApplicationController
  def index
    date_range = Date.today.at_beginning_of_day... Date.today.at_end_of_day

    @test_sent_overall = User.test_sent_overall.count
    @test_taken_overall = User.test_taken_overall.count
    @test_not_taken_overall = User.test_not_taken_overall.count
    @test_sent_today = User.test_sent_today.count
    @test_taken_today = User.test_taken_today.count
    @above_benchmark = User.above_benchmark.count

    @recent_tests = Result.includes(:user).where(updated_at: date_range, "user.user_type": "candidate", "user.took_test": true).order("results.updated_at DESC")
    @recent_users = User.includes(:results).where(user_type: "candidate", created_at: date_range).limit(10).order(created_at: :desc)

    update_status
  end

  def update_status
    users = User.where(user_type: "candidate", status: "test_sent", took_test: false)
    current_day = Date.today.strftime("%d-%m-%Y").to_date

    users.each do |user|
      created_day = user.created_at.strftime("%d-%m-%Y").to_date
      diff = (current_day - created_day).to_i

      if diff > 5
        user.update_column(:status, "test_not_taken")
      end
    end
  end
end
