json.id @project.id
json.name @project.name
json.description @project.description

json.issues @project.issues do |issue|
  json.id issue.id
  json.name issue.name
  json.description issue.description
  json.project_id issue.project_id
  json.status issue.status
  json.due issue.due


  json.comments issue.comments do |comment|
    json.id comment.id
  end
end
