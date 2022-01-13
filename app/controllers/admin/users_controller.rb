class Admin::UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :update, :destroy ]
  before_action :set_search_params, only: [ :index ]
  before_action :set_random_password, only: [ :new, :create ]

  def index
    @users = get_user_data

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)

    mail_data = ({
      name: create_user_params[:name],
      email: create_user_params[:email],
      password: create_user_params[:password],
      test_link: "https://hiring.spritle.com"
    }).to_json

    respond_to do |format|
      if @user.save
        UserMailer.send_registeration_mail(mail_data).deliver_now!

        format.html { redirect_to users_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(update_user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy

    Result.where(user_id: @user.id).destroy_all

    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
    end
  end

  def import
  end

  def bulk_upload
    User.import(params[:file])
    redirect_to users_path
  end

  def send_reminder_mail
    params[:user_ids].each do |user_id|
      user = User.where(id: user_id, status: "test_not_taken")
      UserMailer.send_reminder_mail(user[0]).deliver_now! if user.present?

      user.update(reminder_sent: true)
    end

    render :json => { :status => "ok", :message => "Success!" }
  end

  def send_selection_mail
    params[:user_ids].each do |user_id|
      user = User.includes(:results).where(id: user_id, status: "test_taken").where({ results: { percentage: 40..Float::INFINITY }})

      if user.present? && user.length > 0
        UserMailer.send_selection_mail(user[0]).deliver_now!
  
        user.update(selection_sent: true)
      end
    end

    render :json => { :status => "ok", :message => "Success!" }
  end

  def send_rejection_mail
    params[:user_ids].each do |user_id|
      user = User.includes(:results).where(id: user_id, status: "test_taken").where({ results: { percentage: -Float::INFINITY..39 }})

      if user.present? && user.length > 0
        UserMailer.send_rejection_mail(user[0]).deliver_now!
  
        user.update(rejection_sent: true)
      end
    end

    render :json => { :status => "ok", :message => "Success!" }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def create_user_params
      params.require(:user).permit(:name, :email, :mobile, :password)
    end

    def update_user_params
      params.require(:user).permit(:name, :email, :mobile, :status, :took_test)
    end

    def set_search_params
      @date_from = (params[:date_from].present?) ? params[:date_from] : ""
      @date_to = (params[:date_to].present?) ? params[:date_to] : ((params[:date_from].present?) ? params[:date_from] : "")
      @status = params[:status].present? ? (params[:status].slice(-1) == "]" ? (JSON.parse params[:status]) : params[:status]) : ""
      @percentage = params[:percentage].present? ? params[:percentage] : ""
      @above_40 = params[:above_40].present? ? params[:above_40] : ""
    end

    def set_random_password
      @random_password = User.get_random_password
    end

    def get_user_data
      condition = {
        user_type: "candidate",
        created_at: (@date_from != "" && @date_to != "" ) ? (@date_from.to_date.at_beginning_of_day... @date_to.to_date.at_end_of_day) : "",
        status: (@status != "") ? @status : "",
        results: {
          percentage: (@percentage == "above") ? 40..Float::INFINITY : ((@percentage == "below") ? -Float::INFINITY..39 : "")
        }
      }

      if @above_40 != ""
        condition[:results][:updated_at] = condition[:created_at]
        condition[:created_at] = ""
      end

      condition.delete(:created_at) if condition[:created_at] == ""
      condition.delete(:status) if condition[:status] == ""
      condition.delete(:results) if condition[:results][:percentage] == ""

      return User.includes(:results).where(condition).order(created_at: :desc)
    end
end
