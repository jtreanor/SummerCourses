class DropThreadsAndMessges < ActiveRecord::Migration
  def change
    drop_table :messages
    drop_table :message_threads
  end
end
