class CoursesController < ApplicationController
	def show
		@course = Course.find(params[:id])
    @time_table_items = @course.time_table_items
    @locations = Array.new
    @time_table_items.each do |i|
      @locations.push i.location
    end
    #change data of locations to gmap4rails format
    @locations = @locations.to_gmaps4rails

	end
end
