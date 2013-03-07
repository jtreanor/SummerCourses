ActiveAdmin.register Asset do
  index do
  	column :description                     
    column "Preview" do |asset|
    	link_to(image_tag(asset.asset.url(:thumb), :height => '100'), admin_asset_path(asset))
	end   
	column "URL" do |asset|
  		link_to("Full Size", asset.asset.url(:medium))
  	end
    default_actions                   
  end

  show do |asset|
  	attributes_table do
	  	row :id
	  	row :description
	  	row :asset_file_name
	  	row :asset_content_type
	  	row :link do
	  		link_to("Full Size", asset.asset.url(:medium))
	  	end
	  	row :Preview do
	  		link_to(image_tag(asset.asset.url(:thumb), :height => '100'), asset.asset.url(:medium))
	  	end
  	end
  	active_admin_comments
  end

 form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Details" do
   	f.input :description
    f.input :asset, :as => :file
  end
  f.buttons
 end
end
