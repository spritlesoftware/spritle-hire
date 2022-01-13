class Result < ApplicationRecord
  belongs_to :user

  def self.get_test_result(user_id, sign_in_at)
    existTest = Result.find_by(user_id: user_id)

    if existTest.present?
      return existTest
    else
      return Result.create(user_id: user_id, start_time: sign_in_at)
    end
  end
end
