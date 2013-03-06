class IncomingMessagesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
  	if params != nil
  		if params[:envelope] != nil
    		Rails.logger.info params[:envelope][:to] # print the to field to the logs
		end
    Rails.logger.info params[:subject] # print the subject to the logs
    Rails.logger.info params[:plain] # print the decoded body plain to the logs if present
    Rails.logger.info params[:html] # print the html decoded body to the logs if present
    Rails.logger.info params[:attachments][0] if params[:attachments] # A tempfile attachment if attachments is populated
    end

    # Do some other stuff with the mail message

    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end

end
