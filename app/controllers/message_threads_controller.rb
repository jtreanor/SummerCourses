class MessageThreadsController < ApplicationController
  def show
  end

  def new
    @thread = MessageThread.new
  end

  def create
    @thread = MessageThread.new
    @thread.user_email = params[:new_message_thread][:user_email]
    @message = Message.new
    @message.subject = (params[:new_message_thread][:subject])
    @message.content = (params[:new_message_thread][:content])
    #validate the id
    @thread.id = SecureRandom.base64 

    while MessageThread.find_by_id @thread.id
      @thread.id = SecureRandom.base64
    end
    @message.message_thread_id = @thread.id

    if @thread.save && @message.save
      flash[:success] = "Your message has been successfully sent, we will reply your email shortly!"
      redirect_to root_path
    else
      render 'new'
    end
  end
end
