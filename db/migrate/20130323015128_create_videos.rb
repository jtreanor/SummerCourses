class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.text 'url', :null => false
      t.string 'description', :null => false
      t.timestamps
    end
  end
end
