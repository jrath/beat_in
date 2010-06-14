class Comment < ActiveRecord::Base
  belongs_to :source_beat, 
             :class_name => 'Beat',
             :foreign_key => 'source_beat_id'
  belongs_to :comment_beat, 
             :class_name => 'Beat',
             :foreign_key => 'comment_beat_id'

end
