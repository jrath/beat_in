class CreateSessions < ActiveRecord::Migration
  def self.up
   create_table :sessions do |t|
     t.string :session_id
     t.text :data
     t.datetime :updated_at
   end
   add_index :sessions, :session_id, :name => "index_sessions_on_session_id"
  end

  def self.down
    drop_table :sessions
  end
end
