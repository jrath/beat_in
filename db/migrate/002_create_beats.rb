class CreateBeats < ActiveRecord::Migration
  def self.up
    create_table :beats do |t|
      t.string :content, :limit => 150
      t.integer :user_id, :null => false

      t.datetime :created_at
    end

    add_index :beats, :user_id, :name => "index_beats_on_user_id"
    # Adding a full text index for searching the beats, ideally it should be done by something like solr :)
  end

  def self.down
    drop_table :beats
  end
end
