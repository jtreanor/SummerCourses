ActiveAdmin.register Course do
  #if current_admin_user.admin_permission.id == 3
  scope_to :current_admin_user, :association_method => :courses
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
      if params[:course]["refund"].to_i == 1
        params[:course]["refund_enrollments_before"] = Time.now
        puts "Set refund enrolments to now."
      else
        puts "No refund"
      end
      params[:course] = params[:course].except!("refund")

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

      f.has_many :course_images do |fm|
        fm.input :image, :hint => "Click #{link_to("here", admin_images_path)} to manage images."
      end

      #video support

      f.has_many :course_videos do |fm|
        fm.input :video, :hint => "Click #{link_to("here", admin_videos_path)} to manage videos."
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
        f.input :refund, :as => :boolean, :hint => "If your edit is substantial, select this. This will allow all payments made before now to be refunded in full. Note: changes to start and end time of course always have this effect."
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

  show do |c|
    @course = Course.find_by_id(params[:id])
    columns do
      column do

        attributes_table do
          row :title
          row :brief_description
          row :description do
            simple_format (c.description)
          end


          row :deposit do
            number_to_currency(c.deposit, :unit => "&euro;")
          end
          row :price do
            number_to_currency(c.price, :unit => "&euro;")
          end
          row :teacher do
            link_to c.teacher, admin_teacher_path(c.teacher.id)
          end
          row :category do
            link_to c.category.category_name, admin_category_path(c.category.id)
          end
          row "Cancelled" do
            c.is_cancelled ? "Yes" : "No"
          end
          if can?(:manage, Course)
            row :refund_enrollments_before
          end
          row "Page hits" do
            c.hits
          end
          row :number_of_places
          row :enrollments do
            c.enrollments.count
          end
          if @course.enrollments.any?
            row :average_age do
              age_total = 0
              number_total = 0
              @course.enrollments.each do |e|
                age_total = (Date.today.year - e.student.year_of_birth) + age_total
                number_total = number_total + 1
              end
              age_total/number_total
            end
          end
          row :places_remaining


        end

        h3 "Enrolments"
        table class: "index_table index" do
          tr do
            th "Name"
            th "Enrolment Date"
            th "Total Paid"
            th "Cancelled"
            th "Total Refunded"
          end
          odd = true
          Enrollment.where(:course_id => params[:id]).recent.each do |e|
            tr class: odd ? "odd" : "even" do
              td link_to e.student, admin_student_path(e.id)
              td e.created_at.strftime("%b %e, %l:%M %p")
              td number_to_currency(e.total_paid, :unit => "&euro;")
              td e.is_cancelled ? "Yes." : "No"
              td do
                if e.is_cancelled && e.refund_amount > e.total_refunded
                  if e.refund_attempts > 0
                    "Refund processing."
                  else
                    "Refund failed."
                  end
                else
                  number_to_currency(e.total_refunded, :unit => "&euro;")
                end
              end
            end
            odd = !odd
          end
        end


      end

      column do

        if @course.enrollments.any?
          div :class => :panel do
            h3 'Enrollments Per Day'
            #@course = Course.find_by_id(params[:id])

            div :class => :panel_contents do
              render 'enrollments_statistic'
              #render 'enrollments_chart'
            end
          end
          div :class => :panel do
            h3 'Gender Distribution'
            #@course = Course.find_by_id(params[:id])


            div :class => :panel_contents do
              render 'gender_statistic'
            end
          end


          div :class => :panel do
            h3 'Country Distribution'
            #@course = Course.find_by_id(params[:id])


            div :class => :panel_contents do
              render 'country_statistic'
            end
          end
        end
        #column
      end
      #columns
    end

  end

end
