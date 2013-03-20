ActiveAdmin.register MessageThread do
  show do |thread|
  	attributes_table do
	  	row :id
	  	row :user_email
	  	row :subject
	end

	message_thread.messages.each do |m|
		div :class => :panel do
			h3 "User's Question" if !m.is_response
			h3 "Reply by administrator" if m.is_response
			div :class => :panel_contents do
				div :class => "attributes_table message_thread" do
				table do
					th("Message Body")
					td(simple_format(m.content)) 
				end
			end
			end
		end
	end

	@message = Message.new

	div :class => :panel do
		h3 "Reply"
		div :class => :panel_contents do
		form_for @message do |f|
			f.hidden_field :message_thread_id, value: message_thread.id
			#Every reply has is_response = true
			f.hidden_field :is_response, value: true
			f.text_area :content
	    	f.submit "Reply"
		end
		end
	end

  end
  
end
