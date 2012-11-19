json.id @issue.id
json.name @issue.name
json.description @issue.description
json.status @issue.status

json.project_id @issue.project_id

json.comments @issue.comments do |comment|
  json.id comment.id
  json.content comment.content
end
