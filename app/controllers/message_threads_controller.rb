class MessageThreadsController < ApplicationController
  def show
  end

  def new
    @thread = MessageThread.new
    @message = Message.new
  end

  def create
    @thread = MessageThread.create(user_email: params[:new_message_thread][:user_email],
                                      subject: params[:new_message_thread][:subject])

    if @thread.save
      @message = @thread.messages.create(content: params[:new_message_thread][:content])
      if @message.save
        flash[:success] = "Your message has been successfully sent, we will reply by email shortly!"
        redirect_to root_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end
end
