ActiveAdmin.register CourseAsset do
  menu false
  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Details" do
   	f.input :course
    f.input :asset
  end



  f.inputs "Asset", :for => [:asset, Asset.new ] do |fm|
  	  fm.input :description
      fm.input :asset, :as => :file
  end

  f.buttons
 end
end
