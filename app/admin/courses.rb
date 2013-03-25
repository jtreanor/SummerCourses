ActiveAdmin.register Course do
  #if current_admin_user.admin_permission.id == 3
    scope_to :current_admin_user
  #end

  actions :all, :except => [:destroy]

  member_action :cancel, :method => :get do
    @course = Course.find_by_id(params[:id])

    if @course.nil?
      flash[:notice] = "Unknown course."
      redirect_to admin_courses_path
    elsif @course.is_cancelled
      flash[:notice] = "#{@course.title} is already cancelled."
      redirect_to admin_courses_path
    end
  end

  member_action :do_cancel, :method => :post do
    @course = Course.find_by_id(params[:id])
    if @course.nil?
      flash[:notice] = "Unknown course."
    elsif !@course.is_cancelled
      @course.cancel
      flash[:notice] = "#{@course.title} has been successfully cancelled."
    elsif @course.is_cancelled
      flash[:notice] = "#{@course.title} is already cancelled."
    end
    redirect_to admin_courses_path
  end

  controller do
=begin
    def index
      if can? :manage, Course
        @courses = Course.page params[:page] #you must call .page for the index to work.
      else
        @courses = current_admin_user.teacher.courses.page params[:page]
      end
      index! #this is needed unless you are using custom views
    end
=end

    #Custom code for editing courses
    def update
      #Check if refund was checked
      if params[:course]["refund_enrollments_before"].to_i == 1
        params[:course]["refund_enrollments_before"] = Time.now
        puts "Set refund enrolments to now."
      else
        puts "Not allowing refund"
        params[:course] = params[:course].except!("refund_enrollments_before")
      end
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
      course_diff_hash = new_course_hash.diff(old_course_hash)

      #Has the timetable been changed
      time_table_change = old_time_table_items != new_time_table_items

      #If start or end time has changed
      if old_time_table_items.first[:start_time] != new_time_table_items.first[:start_time] || old_time_table_items.last[:end_time] != new_time_table_items.last[:end_time]
        new_course.set_refund_enrollments_before_to_now
        new_course.save
      end

      logger.info "Course Diff: " + course_diff_hash.to_s

      #If there have been changes, notify all users.
      if new_course_hash != old_course_hash || time_table_change
        #Notify enrollees of changes
        logger.info "Sending diff emails"
        new_course.notify_enrollees_of_edit(course_diff_hash, time_table_change)
      end
    end
  end

  form :html => {:enctype => "multipart/form-data"} do |f|
    f.inputs "Course Details" do
      f.input :title
      f.input :brief_description, :input_html => {:rows => 5}
      f.input :description
      f.input :teacher, :hint => "Click #{link_to("here", admin_teachers_path)} to manage teachers."
      f.input :number_of_places
      if f.object.new_record?
        f.input :price
        f.input :deposit
      else
        f.input :price, :hint => "Price may not be changed once a course is created. If necessary, you may cancel a course and start a new one.", :input_html => {:value => number_to_currency(f.object.price, :unit => "&euro;"), :type => "text", :disabled => "true"}
        f.input :deposit, :hint => "Deposit may not be changed once a course is created. If necessary, you may cancel a course and start a new one.", :input_html => {:value => number_to_currency(f.object.deposit, :unit => "&euro;"), :type => "text", :disabled => "true"}
      end
      f.input :category, :hint => "Click #{link_to("here", admin_categories_path)} to manage categories."
    end


    #Existing course images/videos
    f.inputs "Assets" do
      f.has_many :images do |fm|
        fm.input :description
        fm.input :asset, :as => :file, :hint => (f.template.image_tag(fm.object.asset.url(:thumb)) unless fm.object.new_record?)
      end

      #video support
      f.has_many :videos do |cv|
        cv.input :description
        cv.input :url, :label => "Video URL", :input_html => {:rows => 1}, :hint => "Video from YouTube, Vimeo or Dailymotion is supported."
      end
    end

    f.inputs "Schedule" do
      f.has_many :time_table_items do |tt|
        tt.input :location, :hint => "Click #{link_to("here", admin_locations_path)} to manage locations."
        tt.input :room
        tt.input :start_time, :as => :just_datetime_picker
        tt.input :end_time, :as => :just_datetime_picker
      end
    end

    if !f.object.new_record?
      f.inputs "Allow Refund" do
        f.input :refund_enrollments_before, :as => :boolean, :hint => "If your edit is substantial, select this. This will allow all payments made before now to be refunded in full. Note: changes to start and end time of course always have this effect."
      end
    end

    f.actions
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
#Why manually set defaults action
    if can?(:manage, Course)
      column "Actions" do |c|
        "#{link_to("View", admin_course_path(c))} #{link_to("Edit", edit_admin_course_path(c))} #{link_to("Cancel", cancel_admin_course_path(c))}".html_safe
      end
    else
      default_actions
    end

  end

end
