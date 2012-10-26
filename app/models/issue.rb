class Issue < ActiveRecord::Base
  attr_accessible :description, :name, :project_id

  belongs_to :project
end
