class MessagesController < ApplicationController
  def show
  end

  def new
    @message = Message.new

    MessageMailer.message().deliver
  end

  def create
    @message = Message.new(params[:message])
    @message.save
  end
end
