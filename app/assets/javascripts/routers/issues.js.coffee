HQ.Routers.Issues =
  gotoNewIssue: (id) ->
    project = HQ.projects.get(id) || new HQ.Models.Project {id: id}
    project.fetch()
    issue = new HQ.Models.Issue project: project
    view = new HQ.Views.NewIssue model: issue
    @swap view, issue

  newIssue: (id) ->
    @gotoNewIssue id
  

  gotoIssue: (issue) ->
    view = new HQ.Views.Issue model: issue
    @navigate "/projects/#{issue.get('project_id')}/issues/#{issue.get('id')}"
    @swap view, issue

  issue: (project_id, id) ->
    issue = new HQ.Models.Issue id: id, project_id: project_id
    issue.fetch()
    @gotoIssue issue
