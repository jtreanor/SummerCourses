ActiveAdmin.register Image do
  menu :if => proc{ can?(:manage, Teacher) }
  index do
  	column :description                     
    column "Preview" do |image|
    	link_to(image_tag(image.asset.url(:thumb), :height => '100'), admin_image_path(image))
	  end   
	  column "URL" do |image|
  		link_to("Full Size", image.asset.url(:medium))
  	end
    default_actions                   
  end

  show do |image|
  	attributes_table do
	  	row :id
	  	row :description
	  	row :asset_file_name
	  	row :asset_content_type
	  	row :link do
	  		link_to("Full Size", image.asset.url(:medium))
	  	end
	  	row :Preview do
	  		link_to(image_tag(image.asset.url(:thumb), :height => '100'), image.asset.url(:medium))
	  	end
  	end
  	active_admin_comments
  end

 form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Details" do
   	f.input :description
    f.input :asset, :as => :file, :hint => (f.template.image_tag(f.object.asset.url(:thumb)) unless f.object.new_record?)
  end
  f.buttons
 end
end
