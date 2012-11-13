class Project < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :issues

  validates_presence_of :name
  validates_presence_of :description
end
