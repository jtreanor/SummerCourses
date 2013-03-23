class CreateCourseVideos < ActiveRecord::Migration
  def change
    create_table :course_videos do |t|
      t.integer 'course_id'
      t.integer 'video_id'
      t.timestamps
    end
    add_index "course_videos", ["course_id", "video_id"], :name => "index_course_videos_on_course_id_and_video_id", :unique => true
    add_index "course_videos", ["video_id"], :name => "course_videos_video_id_fk"
  end
end
