class CoursesController < ApplicationController
	def show
		@course = Course.find(params[:id])
    @time_table = @course.time_table_items
    @locations = Array.new
    @time_table.each do |t|
      @locations.push t.location
    end
    @locations = @locations.to_gmaps4rails

	end
end
