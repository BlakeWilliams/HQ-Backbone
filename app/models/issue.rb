class Issue < ActiveRecord::Base
  attr_accessible :description, :name, :project_id, :status, :due

  validates_presence_of :name
  validates_presence_of :description

  belongs_to :project
  has_many :comments, as: :commentable

  def due=(date)
    date = Date.strptime(date, '%m/%d/%Y') if date.class == String
    puts date.class
    write_attribute(:due, date)
  end

  def due
    date = read_attribute(:due)
    date.strftime('%m/%d/%Y')
  end
end
