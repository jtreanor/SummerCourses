class MessageThreadsController < ApplicationController
    def show
       @thread = MessageThread.find(params[:id])
  end

  def new
    @thread = MessageThread.new
  end

  def contact
    @thread = MessageThread.new
    @thread.set_message(Message.new)
  end

  def create
    @thread = MessageThread.new
    @thread.user_email = params[:new_message_thread][:user_email]
    message = Message.new
    message.subject = (params[:new_message_thread][:subject])
    @thread.set_message(message)
    @thread.save
    @thread.get_message.message_thread_id = @thread.id
    @thread.get_message.save
    redirect_to contact_path
  end
end
