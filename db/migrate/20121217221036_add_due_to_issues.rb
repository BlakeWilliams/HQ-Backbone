class AddDueToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :due, :date

    Issue.all.each do |issue|
      issue.update_attribute :due, Date.today
    end
  end
end
