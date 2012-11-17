HQ.Collections.Projects = Backbone.Collection.extend
  model: HQ.Models.Project
  url: '/projects'

  findIssue: (project_id, id) ->
    project = @get(project_id)
    return unless project
    
    project.issues.get(id)
    
