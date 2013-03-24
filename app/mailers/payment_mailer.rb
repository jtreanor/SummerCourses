class PaymentMailer < ActionMailer::Base
  default from: "UCC Summer Courses Office <admin@summercourses.mailgun.org>"

  def payment_receipt(payment)
  	@payment = payment
  	@enrollment = payment.enrollment
    mail(:to => payment.enrollment.student.email, :subject => "Your receipt for #{@enrollment.course.title}")
    logger.info "Sent email with subject #{"Your receipt for #{@enrollment.course.title}"} to #{payment.enrollment.student.email}"
  end

  def refund_receipt(enrollment)
    @enrollment = enrollment
    mail(:to => @enrollment.student.email, :subject => "Your refund for #{@enrollment.course.title}")
    logger.info "Sent email with subject #{"Your refund for #{@enrollment.course.title}"} to #{@enrollment.student.email}"
  end

  def refund_processing(enrollment)
    @enrollment = enrollment

    mail(:to => @enrollment.student.email, :subject => "Your cancellation of #{@enrollment.course.title}")
    logger.info "Sent email with subject #{"Your cancellation of #{@enrollment.course.title}"} to #{@enrollment.student.email}"
  end

end
