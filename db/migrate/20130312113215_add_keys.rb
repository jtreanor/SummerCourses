class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "time_table_items", "courses", :name => "time_table_items_course_id_fk"
    add_foreign_key "time_table_items", "locations", :name => "time_table_items_location_id_fk"
  end
end
