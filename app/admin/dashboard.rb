ActiveAdmin.register_page "Dashboard" do
  menu :if => proc{ can?(:manage, Teacher) }

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
       column do
         panel "Recent Enrolments" do
           ul do
             Enrollment.limit(5).map do |e|
               li link_to(e.student,admin_student_path(e.student.id)) + " enroled in " + link_to(e.course.title,admin_student_path(e.course.id)) + " (#{e.payments.first.created_at.strftime("%b %e, %l:%M %p")})."
             end
           end
         end
         panel "Enrolments per day" do
          render "enrolments_chart"
         end
       end

       column do

            h3 "Courses Summary"
            table class: "index_table index" do
                
                tr do 
                  th "Course Title"
                  th "Start Date"
                  th "Number of enrolments"
                end
                odd = true
              Course.limit(10).each do |c|
                tr class: odd ? "odd" : "even" do 
                  td link_to c.title, admin_course_path(c.id)
                  td c.start_time.strftime("%B #{c.start_time.day.ordinalize} %Y")
                  td c.enrollments.count
                end
                odd = !odd
              end
            end

            br
         
            h3 "Recent Messages"
            table class: "index_table index" do
                
                tr do 
                  th "User Email"
                  th "Subject"
                  th "Last Question"
                end
                odd = true
              MessageThread.limit(10).each do |mt|
                tr class: odd ? "odd" : "even" do 
                  td link_to mt.user_email, admin_message_path(mt.id)
                  td link_to mt.subject, admin_message_path(mt.id)
                  td mt.sorted_user_messages.last.created_at.strftime("%b %e, %l:%M %p")
                end
                odd = !odd
              end
            end

         #column
       end
       #columns
     end


  end # content
end
