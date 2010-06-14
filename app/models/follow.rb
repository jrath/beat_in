class Follow < ActiveRecord::Base
  belongs_to :followee_user,
             :class_name => 'User',
             :foreign_key => 'followee_id'

  belongs_to :follower_user,
             :class_name => 'User',
             :foreign_key => 'follower_id'

end
