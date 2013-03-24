ActiveAdmin.register Course do
  actions :all, :except => [:destroy]

  controller do
      # This code is evaluated within the controller class

      def update
        #Course before edit
        old_course = Course.find_by_id(params[:id])
        old_course_hash = old_course.attributes.to_options
        old_time_table_items = []
        old_course.time_table_items.each do |tt|
          old_time_table_items << tt.attributes.to_options
        end
        super
        #Course after edit
        new_course = Course.find_by_id(params[:id])
        new_course_hash = new_course.attributes.to_options
        new_time_table_items = []
        new_course.time_table_items.each do |tt|
          new_time_table_items << tt.attributes.to_options
        end

        #Returns hash of changes
        course_diff_hash = new_course_hash.diff( old_course_hash )

        #Has the timetable been changed
        time_table_change = old_time_table_items != new_time_table_items

        #If start or end time has changed
        if (old_time_table_items.first.start_time != new_time_table_items.first.start_time) 
          || (new_time_table_items.last.end_time != new_time_table_items.last.end_time)
          new_course.set_refund_enrollments_before_to_now
        end

        logger.info "Course Diff: " + course_diff_hash.to_s

        if new_course_hash != old_course_hash || time_table_change
          #Notify enrollees of changes
          logger.info "Sending diff emails"
          new_course.notify_enrollees_of_edit(course_diff_hash, time_table_change)
        end
      end
  end

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
        f.has_many :course_images do |ca|
          ca.inputs "New Images", :for => [:image, Image.new ] do |fm|
              fm.input :description
              fm.input :asset, :as => :file
          end
        end
      end
    else
      #Existing course images/videos
      f.inputs "Assets" do
        f.has_many :course_images do |ca|
          ca.inputs "Existing Asset" do
            ca.input :image
          end
        end
      end
      
    end
    #video support
    f.inputs 'Video' do
      f.has_many :videos do |cv|
          cv.input :description
          cv.input :url
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
