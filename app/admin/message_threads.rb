ActiveAdmin.register MessageThread do
  show do |asset|
  	attributes_table do
	  	row :id
	  	row :user_email
	end

	message_thread.messages.each do |m|
		div :class => :panel do
			h3 "Message"
			div :class => :panel_contents do
				table :class=> :attributes_table do
					th("Message Body")
					td(simple_format(m.content)) 
				end
			end
		end
	end

  	active_admin_comments
  end
  
end
