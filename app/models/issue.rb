class Issue < ActiveRecord::Base
  attr_accessible :description, :name, :project_id, :status

  belongs_to :project

  validates_presence_of :name
  validates_presence_of :description
end
