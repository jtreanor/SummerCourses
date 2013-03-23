class PaymentMailer < ActionMailer::Base
  default from: "UCC Summer Courses Office <admin@summercourses.mailgun.org>"

  def payment_receipt(payment)
  	@transaction = payment.transaction
  	@enrollment = payment.enrollment
    mail(:to => payment.enrollment.student.email, :subject => "Your receipt for #{@enrollment.course}")
    logger.info "Sent email with subject #{"Your receipt for #{@enrollment.course}"} to #{payment.enrollment.student.email}"
  end

  def refund_receipt(refund)
  	@transaction = transaction
  	@enrollment = refund.enrollment
  	mail(:to => enrollment.student.email, :subject => "Your refund for #{@enrollment.course}")
    logger.info "Sent email with subject #{"Your refund for #{@enrollment.course}"} to #{enrollment.student.email}"
  end
end
