class MessageThreadsController < ApplicationController
  def show
  end

  def new
    @thread = MessageThread.new

    MessageMailer.message().deliver
  end

  def create
    @thread = MessageThread.new
    @thread.user_email = params[:new_message_thread][:user_email]
    @message = Message.new
    @message.subject = (params[:new_message_thread][:subject])
    @message.content = (params[:new_message_thread][:content])
    #@thread.set_message(message)
    if @thread.save
      @message.message_thread_id = @thread.id
      if  @message.save
        flash[:success] = "Your message has been successfully sent, we will reply your email shortly!"
        redirect_to root_path
      end
    else
      render 'new'
    end
  end
end
