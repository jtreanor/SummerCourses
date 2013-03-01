class EnrollmentsController < ApplicationController
	before_filter :authenticate_student!

	def index
		@enrollments = Enrollment.find_all_by_student_id(current_student.id)
	end

	def new
		@course = Course.find_by_id(params[:id])

		Braintree::Configuration.environment = :sandbox
		Braintree::Configuration.merchant_id = "6b6c6smqn4ddbrvy"
		Braintree::Configuration.public_key = "bkmz9ztnjt6f3jvj"
		Braintree::Configuration.private_key = "e37569f722592948d8e9e262fec86478"

		@tr_data = Braintree::TransparentRedirect.transaction_data(
			:redirect_url => enrollment_result_url(@course.id),
			:transaction => {
			  :type => "sale",
			  :amount => @course.price.to_s,
			  :options => {
			    :submit_for_settlement => true
			    }
			  })
	end

	def result
		result = Braintree::TransparentRedirect.confirm(request.query_string)
		@course = Course.find_by_id(params[:id])
		error = true

	  if result.success?
	    transaction = Transaction.create(id: result.transaction.id, amount: result.transaction.amount, timestamp: Date.today)
	    if transaction.save
	    	enrollment = Enrollment.create(student_id: current_student.id, course_id: @course.id)
	    	if enrollment.save
	    		payment = Payment.create(id: transaction.id, enrollmentID: enrollment.id)
	    		if payment.save
	    			error = false
	    			@message = "Transaction Status: #{result.transaction.status}. The transaction_id is #{result.transaction.id}"
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

