class CoursesController < ApplicationController
	def show
		@course = Course.find(params[:id])
		@course.hits = @course.hits + 1
		@course.save
	end
end
