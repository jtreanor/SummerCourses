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
      #f.inputs "Category", :for => [:category, f.object.category || Category.new] do |meta_form|
      #  f.input :category, label: "Existing category" 
      #  meta_form.input :category_name, label: "New Category"
      #end
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
