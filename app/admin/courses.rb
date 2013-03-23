ActiveAdmin.register Course do
  actions :all, :except => [:destroy]

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Course Details" do
   	  f.input :title
   	  f.input :brief_description
   	  f.input :description
      f.input :teacher
	    f.input :number_of_places
      if f.object.new_record?
        f.input :price
        f.input :deposit
      else
        f.input :price, :hint => "Price may not be changed once a course is created. If necessary, you may cancel a course and start a new one." ,:input_html => { :value => number_to_currency(f.object.price, :unit => "&euro;"), :type => "text", :disabled => "true" }
        f.input :deposit, :hint => "Deposit may not be changed once a course is created. If necessary, you may cancel a course and start a new one.", :input_html => { :value => number_to_currency(f.object.deposit, :unit => "&euro;"), :type => "text", :disabled => "true" }
      end
	    f.input :category
    end

    if f.object.new_record?
      f.inputs "Images" do
        f.has_many :course_pictures do |ca|
          ca.inputs "Existing Images" do
            ca.input :asset
          end
          ca.inputs "New Images", :for => [:image, Image.new ] do |fm|
              fm.input :description
              fm.input :asset, :as => :file
          end
        end
      end
    else
      #Existing course images/videos
    end

    if !f.object.new_record?
      f.button "Cancel Course"
    end

    f.buttons
  end

  index do
    column "Course ID" do |c|
          link_to c.id, admin_course_path(c)
    end
    column "Title" do |c|
          link_to c.title, admin_course_path(c)
    end
    column "Brief Description" do |c|
      truncate(c.brief_description, :length => 50)
    end
    default_actions
  end

end
