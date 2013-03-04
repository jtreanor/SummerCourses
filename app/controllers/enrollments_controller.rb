class EnrollmentsController < ApplicationController
	before_filter :authenticate_student!

	def tr_data(amount, redirect_url)
		Braintree::Configuration.environment = :sandbox
		Braintree::Configuration.merchant_id = "6b6c6smqn4ddbrvy"
		Braintree::Configuration.public_key = "bkmz9ztnjt6f3jvj"
		Braintree::Configuration.private_key = "e37569f722592948d8e9e262fec86478"

		Braintree::TransparentRedirect.transaction_data(
			:redirect_url => redirect_url,
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

	def edit
		@enrollment = Enrollment.find_by_id(params[:id])

		@full_tr_data = tr_data(@enrollment.balance_due,enrollment_result_url(@enrollment.course.id))
	end

	def new
		@course = Course.find_by_id(params[:id])

		if current_student.enrollments.find_by_course_id(@course.id) == nil
			@full_tr_data = tr_data(@course.price.to_s,enrollment_result_url(@course.id))
			@deposit_tr_data = tr_data(@course.deposit.to_s,enrollment_result_url(@course.id))

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
	    	enrollment = current_student.enrollments.find_by_course_id(@course.id)
	    	if enrollment == nil
	    		enrollment = Enrollment.create(student_id: current_student.id, course_id: @course.id)
	    	end
	    	if enrollment.save
	    		payment = Payment.create(transaction_id: transaction.id, enrollment_id: enrollment.id)
	    		if payment.save
	    			error = false
	    			@message = "The payment has been accepted and you have been succesfully enrolled in " + @course.title
	  				flash[:notice] = @message
	  				redirect_to enrollments_path
	    		end
	    	end
		end
	  end
	  if error
	  	if result.success?
	  		#TODO - refund transaction if something went wrong 
	  	else
	  		@message = "Message: #{result.message}"
	  		flash[:notice] = @message
	  		redirect_to new_enrollment_path(@course.id)
	  	end

	  end
	end

	def destroy
		
	end
end

