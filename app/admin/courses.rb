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
=begin
    f.inputs "Images or Videos", :for => [:course_assets, CourseAsset.new ] do |fm|
    	fm.inputs "Asset", :for => [:asset, fm.object.asset || Asset.new] do |fmi|
    		fmi.input :description
      		fmi.input :file, :for => :asset, :as => :file
    	end
  	end
=end
	f.inputs "Assets" do
	  	f.has_many :course_assets do |ca|
	  		ca.inputs "Asset" do
	    		ca.input :asset
	  		end
	  	end
  	end

  	f.buttons
  end
end
