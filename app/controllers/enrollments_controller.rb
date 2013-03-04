class EnrollmentsController < ApplicationController
	before_filter :authenticate_student!

	def tr_data(amount,course_id)
		Braintree::TransparentRedirect.transaction_data(
			:redirect_url => enrollment_result_url(course_id),
			:transaction => {
			  :type => "sale",
			  :amount => amount,
			  :options => {
			    :submit_for_settlement => true
			    }
			  })
	end

	def index
		@enrollments = current_student.enrollments
	end

	def new
		@course = Course.find_by_id(params[:id])

		if current_student.enrollments.find_by_course_id(@course.id) == nil
			Braintree::Configuration.environment = :sandbox
			Braintree::Configuration.merchant_id = "6b6c6smqn4ddbrvy"
			Braintree::Configuration.public_key = "bkmz9ztnjt6f3jvj"
			Braintree::Configuration.private_key = "e37569f722592948d8e9e262fec86478"

			@full_tr_data = tr_data(@course.price.to_s,@course.id)
			@deposit_tr_data = tr_data(@course.deposit.to_s,@course.id)

		else
			#already enrolled
		end
	end

	def result
		result = Braintree::TransparentRedirect.confirm(request.query_string)
		@course = Course.find_by_id(params[:id])
		@message =""
		error = true

	  if result.success?
	    transaction = Transaction.create(id: result.transaction.id, amount: result.transaction.amount, timestamp: DateTime.now)
	    if transaction.save
	    	enrollment = Enrollment.create(student_id: current_student.id, course_id: @course.id)
	    	if enrollment.save
	    		payment = Payment.create(transaction_id: transaction.id, enrollment_id: enrollment.id)
	    		if payment.save
	    			error = false
	    		end
	    	end
		end
	  end
	  if error
	  	if result.success?
	  		#TODO - refund transaction if something went wrong 
	  	else
	  		@message = "Message: #{result.message}"
	  	end

	  end
	end

	def create
	end
end

