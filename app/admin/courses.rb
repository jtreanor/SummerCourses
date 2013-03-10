ActiveAdmin.register Course do
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Course Details" do
   	  f.input :title
   	  f.input :brief_description
   	  f.input :description
      f.input :teacher_id
	  f.input :number_of_places
	  f.input :price
	  f.input :deposit
	  f.input :category
    end

	f.inputs "Assets" do
	  	f.has_many :course_assets do |ca|
	  		ca.inputs "Existing Asset" do
	    		ca.input :asset
	  		end
        ca.inputs "New Asset", :for => [:asset, Asset.new ] do |fm|
            fm.input :description
            fm.input :asset, :as => :file
        end
	  	end
  	end

  	f.buttons
  end
end
