class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :id => false do |t|
      t.integer :source_beat_id
      t.integer :comment_beat_id
    end

    add_index :comments, :source_beat_id, :name => "index_comments_on_source_beat_id"
    add_index :comments, :comment_beat_id, :name => "index_comments_on_comment_beat_id"
  end

  def self.down
    drop_table :comments
  end
end
