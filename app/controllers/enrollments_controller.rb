class EnrollmentsController < ApplicationController
	def index
		@enrollments = Enrollment.find_all_by_studentID(current_student.id)
	end

	def new
	end

	def create
	end
end
