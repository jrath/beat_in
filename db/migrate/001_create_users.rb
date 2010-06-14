class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string   :login,                     :limit => 40, :null => false
      t.string   :name,                      :limit => 100, :default => '', :null => false
      t.string   :email,                     :limit => 100, :null => false
      t.string   :crypted_password,          :limit => 40
      t.string   :salt,                      :limit => 40
      t.datetime :created_at                
      t.datetime :updated_at                
      t.string   :remember_token,            :limit => 40
      t.datetime :remember_token_expires_at 
      t.string   :activation_code,           :limit => 40
      t.datetime :activated_at              

    end
    add_index :users, :login, :unique => true, :name => "index_users_on_login"

    # Adding a full text index for searching the users, ideally it should be done by something like solr :)
  end

  def self.down
    drop_table "users"
  end
end
