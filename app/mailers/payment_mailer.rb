class PaymentMailer < ActionMailer::Base
  default from: "UCC Summer Courses Office <admin@summercourses.mailgun.org>"

  def payment_receipt(payment,transaction)
  	@transaction = transaction
  	@enrollment = payment.enrollment
    mail(:to => payment.enrollment.student.email, :subject => "Your receipt for #{@enrollment.course}")
    logger.info "Sent email with subject #{"Your receipt for #{@enrollment.course}"} to #{payment.enrollent.student.email}"
  end
end
