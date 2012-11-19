class Issue < ActiveRecord::Base
  attr_accessible :description, :name, :project_id, :status

  validates_presence_of :name
  validates_presence_of :description

  belongs_to :project
  has_many :comments, as: :commentable
end
