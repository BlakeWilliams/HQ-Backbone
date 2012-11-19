class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :user_id

  validates_presence_of :content

  belongs_to :commentable, polymorphic: true
end
