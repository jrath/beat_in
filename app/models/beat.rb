class Beat < ActiveRecord::Base
  belongs_to :user
  has_many :comments,
           :foreign_key => 'source_beat_id'

  has_many :comment_beats,
           :through => :comments,
           :foreign_key => 'comment_beat_id'
end
