class UserMailer < ActionMailer::Base
  def signup_notification(user)
    from       VidliConfig.email_support
    recipients user.email
    sent_on    Time.now
    body       :user => user
    subject    "Your Account has been created!"
  end
end