class CoursesController < ApplicationController
	def show
		@course = Course.find(params[:id])
		
		if @course.is_cancelled
			flash.now[:notice] = "This course has been cancelled."
		elsif @course.end_time < DateTime.now
			flash.now[:notice] = "This course has ended."
		elsif @course.start_time < DateTime.now
			flash.now[:notice] = "This course has already begun."
		end

		@course.hits = @course.hits + 1
		@course.save
	end
end
