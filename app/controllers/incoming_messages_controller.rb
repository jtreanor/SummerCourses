class IncomingMessagesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    sender  = params['sender']
    subject = params['subject']

     # get the "stripped" body of the message, i.e. without
     # the quoted part
    actual_body = params["stripped-text"]

    # Do some other stuff with the mail message

    MessageThread.find_all_by_user_email(sender).each do |thread|
      if subject.include? thread.id
        thread.messages.create(subject: subject, content: actual_body, is_response: false)
        logger.info "Put message from " + sender + " into " + thread.id
      else
        logger.info "DID NOT Put message from " + sender + " into " + thread.id
      end
    end

    render :text => "OK"
  end

end
