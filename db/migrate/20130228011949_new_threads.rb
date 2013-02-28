class NewThreads < ActiveRecord::Migration
  def change
    create_table :message_threads do |t|
      t.string   :user_email, :null => false
      t.timestamps
    end
  end
end
