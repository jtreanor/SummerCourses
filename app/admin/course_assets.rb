ActiveAdmin.register CourseAsset do
  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Details" do
   	f.input :course
    f.input :asset
  end
  f.buttons
 end
end
