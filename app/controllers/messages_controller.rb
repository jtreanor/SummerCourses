class MessagesController < ApplicationController
	before_filter :authenticate_admin_user!

	def create
		@message = Message.create(params[:message])

		if (@message.save)
			flash[:success] = "Reply has been sent by email."
		else
			flash[:warning] = "Something went wrong."
		end

		redirect_to admin_message_path(@message.message_thread.id)
	end
end
