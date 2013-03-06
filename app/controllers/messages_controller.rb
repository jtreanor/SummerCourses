class MessagesController < ApplicationController
  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    @message.save
  end
end
