HQ.ProjectRoutes =
  gotoProjects: (projects) ->
    @navigate "/projects"
    view = new HQ.ProjectIndex collection: projects
    @swap view, projects

  projectIndex: ->
    projects = HQ.projects
    @gotoProjects HQ.projects
    console.log 'hi'


  gotoProject: (project) ->
    @navigate "/projects/#{project.get 'id'}"
    view = new HQ.ProjectShow model: project
    @swap view, project

  showProject: (id) ->
    project = HQ.projects.get(id) || new HQ.Project {id: id}
    @gotoProject project


  gotoNewProject: ->
    project = new HQ.Project()
    @navigate "/projects/new"
    view = new HQ.ProjectNew model: project
    @swap view, project

  newProject: ->
    @gotoNewProject

