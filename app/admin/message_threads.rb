ActiveAdmin.register MessageThread do
  show do |thread|
  	attributes_table do
	  	row :id
	  	row :user_email
	end

	message_thread.messages.each do |m|
		div :class => :panel do
			h3 "Message"
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
			f.text_area :content
	    	f.submit "Reply"
		end
		end
	end

  end

form  do |f|

	f.inputs "Reply" do
    	f.has_many :messages do |m|
    		m.input :content
    	end

    end

    f.buttons

    div :class => :panel do
		h3 "Details"
		div :class => :panel_contents do
			div :class => "attributes_table message_thread" do
				table do
					th("User Email")
					td(message_thread.user_email)

					tr
					th(:subject)
					td(message_thread.subject)
				end
			end
		end
	end

	message_thread.messages.each do |m|
		div :class => :panel do
			h3 "Message"
			div :class => :panel_contents do
				div :class => "attributes_table message_thread" do
					table do
						th("Date")
						td(m.created_at)

						tr
						th("Message Body")
						td(simple_format(m.content)) 
					end
				end
			end
		end
    end

end
  
end
