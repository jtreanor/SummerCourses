class EnrollmentsController < ApplicationController
	def index
		@enrollments = Enrollment.find_all_by_studentID(current_student.id)
	end

	def new
		@course = Course.find_by_id(params[:id])

		Braintree::Configuration.environment = :sandbox
		Braintree::Configuration.merchant_id = "6b6c6smqn4ddbrvy"
		Braintree::Configuration.public_key = "bkmz9ztnjt6f3jvj"
		Braintree::Configuration.private_key = "e37569f722592948d8e9e262fec86478"

		@tr_data = Braintree::TransparentRedirect.transaction_data(
			:redirect_url => enrollment_result_url,
			:transaction => {
			  :type => "sale",
			  :amount => "1000.00",
			  :options => {
			    :submit_for_settlement => true
			    }
			  })
	end

	def result
		result = Braintree::TransparentRedirect.confirm(request.query_string)

	  if result.success?
	    @message = "Transaction Status: #{result.transaction.status}"
	    # status will be authorized or submitted_for_settlement
	  else
	    @message = "Message: #{result.message}"
	  end
	end

	def create
	end
end

