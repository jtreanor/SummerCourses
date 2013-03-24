class CourseMailer < ActionMailer::Base
  default from: "UCC Summer Courses Office <admin@summercourses.mailgun.org>"

  def course_changes(diff_hash,enrollment)
  	@diff_hash = diff_hash
  	@enrollment = enrollment

  	mail(:to => enrollment.student.email, :subject => "#{enrollment.course.title} changes")
  end

  def enrollment_reminder(enrollment)
  	@enrollment = enrollment

  	mail(:to => enrollment.student.email, :subject => "Course reminder: #{enrollment.course.title}")
  end
end
