ActiveAdmin.register MessageThread do
  show do |asset|
  	attributes_table do
	  	row :id
	  	row :user_email
	end
	div :class => :panel do
		h3 "Messages"
		div :class => :panel_contents do
			message_thread.messages.each do |m|
			div :class => :panel do
			h3 "Message"
			div :class => :panel_contents do
				table :class=> :attributes_table do
					
						th("Message Body")
						td(m.content) 
					
				end
			end
			end
			end
		end
	end
  	active_admin_comments
  end
  
end
