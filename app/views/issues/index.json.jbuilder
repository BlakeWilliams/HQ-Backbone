json.array! @issues do |issue|
  json.id issue.id
  json.name issue.name
  json.description issue.description
  json.status issue.status
  json.due issue.due

  json.comments @issue.comments do |comment|
    json.id comment.id
  end
end
