class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_picture.subject
  #

  # 仮引数として(picture)を、pictureコントローラーcreateアクションから送信
  # createアクションから、ここ(Mailer)、MailViewに渡す流れ
  def sendmail_picture(picture)
    @picture = picture

    mail to: "killingdoll135@icloud.com",
    subject: '【Nonstagram】画像が投稿されました'
  end
end
