HQ.Routers.ProjectRoutes =
  gotoProjects: (projects) ->
    @navigate "/projects"
    view = new HQ.Views.Projects collection: projects
    @swap view, projects

  projects: ->
    @gotoProjects HQ.projects


  gotoProject: (project) ->
    @navigate "/projects/#{project.get 'id'}"
    view = new HQ.Views.Project model: project
    @swap view, project

  project: (id) ->
    project = HQ.projects.get(id) || new HQ.Project {id: id}
    @gotoProject project


  gotoNewProject: ->
    project = new HQ.Project()
    @navigate "/projects/new"
    view = new HQ.ProjectNew model: project
    @swap view, project

  newProject: ->
    @gotoNewProject

