class IncomingMessagesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
  	Rails.logger.info "FROM:" + params[:sender]
    Rails.logger.info "SUBJECT:" + params[:subject] 
    Rails.logger.info "body-plain:" + params["body-plain"]

    # Do some other stuff with the mail message

    render :text => 'success', :status => 200
  end

end
