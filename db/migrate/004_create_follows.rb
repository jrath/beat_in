class CreateFollows < ActiveRecord::Migration
  def self.up
    create_table :follows, :id => false do |t|
      t.integer :follower_id
      t.integer :followee_id

      t.timestamps
    end
    add_index :follows, :follower_id, :name => "index_follows_on_follower_id"
    add_index :follows, :followee_id, :name => "index_follows_on_followee_id"
  end

  def self.down
    drop_table :follows
  end
end
