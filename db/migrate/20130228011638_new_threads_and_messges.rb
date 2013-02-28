class NewThreadsAndMessges < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string   :message_thread_id, :limit => 80, :null => false
      t.text     :subject, :limit => 255, :null => false
      t.boolean  :is_response, :default => false, :null => false
      t.text     :message_text, :null => false
      t.timestamps
    end

    add_index :messages, :message_thread_id, :name => :message_thread_id_idx
  end
end
