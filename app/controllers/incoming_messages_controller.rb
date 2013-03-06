class IncomingMessagesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
  	Rails.logger.info "FROM:" + params[:envelope][:from]
    Rails.logger.info "SUBJECT:" + params[:subject] 
    Rails.logger.info "PLAIN:" + params[:plain]
    Rails.logger.info "REPLY PLAIN:" + params[:reply_plain]

    # Do some other stuff with the mail message

    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end

end
