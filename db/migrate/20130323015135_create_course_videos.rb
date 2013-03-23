class CreateCourseVideos < ActiveRecord::Migration
  def change
    create_table :course_videos do |t|

      t.timestamps
    end
  end
end
