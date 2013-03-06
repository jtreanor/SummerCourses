class IncomingMessagesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    Rails.logger.info "ENVELOPE:" + params[:envelope][:to] + '\n\n\n\n' if params[:envelope] # print the to field to the logs
    Rails.logger.info "SUBJECT:" + params[:subject] + '\n\n\n\n' # print the subject to the logs
    Rails.logger.info "PLAIN:" + params[:plain] + '\n\n\n\n' # print the decoded body plain to the logs if present
    Rails.logger.info "HTML:" + params[:html] + '\n\n\n\n' # print the html decoded body to the logs if present
    Rails.logger.info params[:attachments][0] if params[:attachments] # A tempfile attachment if attachments is populated

    # Do some other stuff with the mail message

    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end

end
