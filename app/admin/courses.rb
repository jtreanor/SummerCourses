ActiveAdmin.register Course do
  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Course Details" do
   	f.input :title
   	f.input :brief_description
   	f.input :description
	f.input :number_of_places
	f.input :price
	f.input :deposit
	f.input :category
  end
  f.buttons
 end
end
