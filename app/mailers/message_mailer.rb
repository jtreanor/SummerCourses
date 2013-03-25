class MessageMailer < ActionMailer::Base
  default from: "UCC Summer Courses Office <ask@summercourses.mailgun.org>"

  def reply_email(message)
    @message = message

    #Get most recent question in the thread.
    @recent_message = @message.message_thread.sorted_user_messages.last

    mail(:to => message.message_thread.user_email, :subject => @message.message_thread.subject_line)
    logger.info "Sent email with subject #{@message.message_thread.subject_line} to #{message.message_thread.user_email}"
  end

  def auto_reply(message)
  	@message = message

  	mail(:to => message.message_thread.user_email, :subject => @message.message_thread.subject_line)
    logger.info "Sent email with subject #{@message.message_thread.subject_line} to #{message.message_thread.user_email}"
  end
end
