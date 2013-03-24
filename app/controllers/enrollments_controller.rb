class EnrollmentsController < ApplicationController
	before_filter :authenticate_student!
 	before_filter :require_uncancelled_course!, only: [:new]
 	before_filter :require_uncancelled_enrollment!, only: [:edit,:cancel,:refund]
  
    def require_uncancelled_course!
      course = Course.find_by_id(params[:id])
      if course.nil?
      	flash[:error] = "This course does not exist."
      	redirect_to enrollments_path
      elsif course.is_cancelled
        flash[:error] = "#{course.title} has been cancelled."
        redirect_to enrollments_path
      end
    end

    def require_uncancelled_enrollment!
      enrollment = Enrollment.find_by_id(params[:id])
      if enrollment.nil?
      	flash[:error] = "This enrolment does not exist."
      	redirect_to enrollments_path
      elsif enrollment.is_cancelled
        flash[:error] = "This enrolment has been cancelled."
        redirect_to enrollments_path
      end
    end

	def tr_data(amount, redirect_url)
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

		if @enrollment.total_due > 0
			@full_tr_data = tr_data(@enrollment.total_due,enrollment_create_url(@enrollment.course.id))
		end
	end

	def new
		@course = Course.find_by_id(params[:id])

		if current_student.enrollments.where("course_id = #{@course.id}  AND is_cancelled = 'false'").empty? 
			#Not already enrolled
			@full_tr_data = tr_data(@course.price.to_s,enrollment_create_url(@course.id))
			@deposit_tr_data = tr_data(@course.deposit.to_s,enrollment_create_url(@course.id))

		else
			#already enrolled
		end
	end

	def create
		result = Braintree::TransparentRedirect.confirm(request.query_string)
		@course = Course.find_by_id(params[:id])
		@message =""
		error = true

	  if result.success?
	    	enrollment = current_student.enrollments.where("course_id = #{@course.id}  AND is_cancelled = 'false'")[0]
	    	if enrollment == nil
	    		enrollment = Enrollment.create(student_id: current_student.id, course_id: @course.id)
	    	end
	    	if enrollment.save
	    		payment = enrollment.payments.create(id: result.transaction.id, amount: result.transaction.amount, created_at: result.transaction.created_at)
	    		if payment.save
	    			error = false
	    			@message = "The payment has been accepted and you have been succesfully enrolled in " + @course.title + "."
	  				flash[:success] = @message
	  				redirect_to enrollments_path
	    		end
	    	end
		
	  end
	  if error
	  	if result.success?
	  		#TODO - refund transaction if something went wrong 
	  	else
	  		@message = "Message: #{result.message}"
	  		flash[:error] = @message
	  		redirect_to new_enrollment_path(@course.id)
	  	end

	  end
	end

	def cancel
		@enrollment = Enrollment.find_by_id(params[:id])
	end

	def refund
		@enrollment = Enrollment.find_by_id(params[:id])

		@message = @enrollment.cancel
		flash[:success] = @message
		redirect_to enrollments_path
	end
end

