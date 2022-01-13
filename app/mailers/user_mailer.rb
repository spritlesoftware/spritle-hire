class UserMailer < ApplicationMailer
  def send_registeration_mail user_data
    @user_data = JSON.parse user_data

    mail(to: @user_data["email"], subject: "SPRITLE FRESHERS DRIVE - REGISTRATION SUCCESS!")
  end

  def send_reminder_mail user_data
    @user_data = user_data

    mail(to: @user_data.email, subject: "SPRITLE FRESHERS DRIVE - REMINDER!")
  end

  def send_selection_mail user_data
    @user_data = user_data

    mail(to: @user_data.email, subject: "SPRITLE FRESHERS DRIVE - SELECTED!")
  end

  def send_rejection_mail user_data
    @user_data = user_data

    mail(to: @user_data.email, subject: "SPRITLE FRESHERS DRIVE - TEST STATUS")
  end
end
