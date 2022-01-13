class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  after_save :change_user_status

  has_many :results

  scope :test_sent_overall, -> { where(user_type: "candidate") }
  scope :test_taken_overall, -> { where(user_type: "candidate", took_test: true) }
  scope :test_not_taken_overall, -> { where(user_type: "candidate", took_test: false) }
  scope :test_sent_today, -> { where(user_type: "candidate", created_at: Date.today.at_beginning_of_day... Date.today.at_end_of_day) }
  scope :test_taken_today, -> { where(user_type: "candidate", took_test: true, created_at: Date.today.at_beginning_of_day... Date.today.at_end_of_day) }
  scope :above_benchmark, -> { User.includes(:results).where(user_type: "candidate", took_test: true, "results.percentage": 40..Float::INFINITY, "results.updated_at": Date.today.at_beginning_of_day... Date.today.at_end_of_day) }

  def self.import(file)
    data = Roo::Excelx.new(file.tempfile)
    headers = data.row(1)

    data.each_with_index do |row, idx|
      next if idx == 0

      user_data = Hash[[headers, row].transpose]
      user_data = user_data.map { |k, v| [k ? (k.class == "String" ? k.strip : k) : k, v ? (v.class == "String" ? v.strip : v) : v] }.to_h
      user_data.merge!(password: self.get_random_password)

      User.create(user_data)

      mail_data = ({
        name: user_data["name"],
        email: user_data["email"],
        password: user_data[:password],
        test_link: "https://hiring.spritle.com"
      }).to_json

      UserMailer.send_registeration_mail(mail_data).deliver_now!
    end
  end

  def self.get_random_password
    string = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
    return (0...10).map { string[rand(string.length)] }.join
  end

  def is_admin?
    self.user_type == "admin"
  end

  def is_candidate?
    self.user_type == "candidate"
  end

  private
    def change_user_status
      if self.took_test == true
        self.update_column(:status, "test_taken")
      else
        Result.where(user_id: self.id).destroy_all
      end
    end
end
