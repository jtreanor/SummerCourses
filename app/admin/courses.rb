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
      f.inputs "Assets" do
        f.has_many :course_assets do |ca|
          ca.inputs "New Asset", :for => [:asset, Asset.new ] do |fm|
              fm.input :description
              fm.input :asset, :as => :file
          end
        end
      end
    else
      #Existing course assets
      f.inputs "Assets" do
        f.has_many :course_assets do |ca|
          ca.inputs "Existing Asset" do
            ca.input :asset
          end
        end
      end
      
    end

    f.inputs "Schedule" do
      f.has_many :time_table_items do |tt|
          tt.input :location
          tt.input :room
          tt.input :start_time, :as => :just_datetime_picker
          tt.input :end_time, :as => :just_datetime_picker
      end
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
