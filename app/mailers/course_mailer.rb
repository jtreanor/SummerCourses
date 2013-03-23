class CourseMailer < ActionMailer::Base
  default from: "UCC Summer Courses Office <admin@summercourses.mailgun.org>"

  def enrollment_reminder(enrollment)
  	@enrollment = enrollment

  	mail(:to => enrollment.student.email, :subject => "Course reminder: #{enrollment.course.title}")
  end
end
