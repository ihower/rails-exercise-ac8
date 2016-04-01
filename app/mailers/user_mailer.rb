class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_comment.subject
  #
  def notify_comment(topic, user)
    @user = user
    @topic = topic

    mail to: user.email, :subject => "有新文章囉!!"
  end
end
