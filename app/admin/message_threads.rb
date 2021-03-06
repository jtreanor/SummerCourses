ActiveAdmin.register MessageThread, :as => "Messages" do
	config.sort_order = "messages.created_at_desc"
  menu :if => proc{ can?(:manage, MessageThread) }, :priority => 4
	actions :all, :except => [:destroy,:edit,:new,:create]
	config.per_page = 10

	index do |thread|
		column "Thread ID" do |t|
      		link_to t.id, admin_message_path(t)
    	end
		column :user_email
		column :subject
		column "Last Question", :sortable => :"messages.created_at" do |t|
      		t.sorted_user_messages.last.created_at.strftime("%b %e, %l:%M %p")
    	end
		default_actions
	end

	controller do
	  def scoped_collection
	    MessageThread.includes(:messages)
	  end
	end

  show :title => :subject do |thread|
  	attributes_table do
	  	row :id
	  	row :user_email
	  	row :subject
	end

	thread.messages.each do |m|
		div :class => :panel do
			h3 "User's Question", :class => "user_question" if !m.is_response
			h3 "Reply by administrator", :class => "admin_response" if m.is_response
			div :class => :panel_contents do
				div :class => "attributes_table message_thread" do
				table do
					th("Message Body")
					td(simple_format(m.content))
					tr
					th("Sent At")
					td(m.created_at)
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
			f.hidden_field :message_thread_id, value: thread.id
			#Every reply has is_response = true
			f.hidden_field :is_response, value: true
			div do
			f.text_area :content, :cols => 8, :rows => 10
			end

			div do
	    		f.submit "Reply"
	    	end
		end
		end
	end

  end
  
end
