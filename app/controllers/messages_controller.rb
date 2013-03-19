class MessagesController < ApplicationController
	before_filter :authenticate_admin_user!

	def create
		@message = Message.create(params[:message])

		redirect_to admin_message_thread_path(@message.message_thread.id)
	end
end
