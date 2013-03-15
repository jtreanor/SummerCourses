class IncomingMessagesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    sender  = params['from']
    subject = params['subject']

     # get the "stripped" body of the message, i.e. without
     # the quoted part
    actual_body = params["stripped-text"]

    # Do some other stuff with the mail message

    Message.create(message_thread_id: MessageThread.first.id, subject: subject, content: actual_body, is_response: false)

    render :text => "OK"
  end

end
