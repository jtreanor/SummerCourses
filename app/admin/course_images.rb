ActiveAdmin.register CourseImage do
  menu false
  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Details" do
   	f.input :course
    f.input :asset
  end



  f.inputs "Image", :for => [:image, Image.new ] do |fm|
  	  fm.input :description
      fm.input :asset, :as => :file
  end

  f.buttons
 end
end
