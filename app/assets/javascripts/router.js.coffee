class HQ.Router extends Backbone.Router
  routes:
    '': 'projectIndex'
    'projects': 'projectIndex'
    'projects/new': 'newProject'
    'projects/:id': 'showProject'
    'projects/:project_id/issues/new': 'newIssue'
    'projects/:project_id/issues/:id': 'showIssue'

  initialize: ->
    if !HQ.projects
      HQ.projects = new HQ.Projects()
      HQ.projects.fetch()

    # Set routers layout and sidebar as variables for access
    @layout = new HQ.Layout()
    @sidebar = new HQ.Sidebar collection: HQ.projects
    @layout.sidebar = @sidebar

    # Render our layout into the body
    $('body').html @layout.render().el

  swap: (child, object, projectName) =>
    # Destroy old layout if it exists and assign new child
    @layout.child._destroy if @layout.child
    @layout.child = child

    # If there is a model/collection passed fetch it then render, otherwise render
    if object && ((object instanceof Backbone.Collection) || !object.isNew())
      object.fetch
        success: =>
          @layout.renderChild()
    else
      @layout.renderChild()

    # Set project name here
    @sidebar.updateProject object

  projectIndex: ->
    projects = HQ.projects
    view = new HQ.ProjectIndex collection: projects

    @sidebar.setChild(new HQ.ProjectIndexSidebar())

    @swap view, projects

  showProject: (id) ->
    project = HQ.projects.get(id) || new HQ.Project {id: id}
    view = new HQ.ProjectShow model: project

    sidebarView = new HQ.ProjectShowSidebar model: project
    @sidebar.setChild(sidebarView)

    @swap view, project

  newProject: ->
    project = new HQ.Project()
    view = new HQ.ProjectNew model: project

    @sidebar.setChild()

    @swap view, project

  newIssue: (id) ->
    project = HQ.projects.get(id) || new HQ.Project {id: id}
    project.fetch()
    issue = new HQ.Issue project: project
    view = new HQ.NewIssue model: issue
    @swap view, issue
  
  showIssue: (project_id, id) ->
    issue = new HQ.Issue id: id, project_id: project_id
    view = new HQ.IssueShow model: issue

    sidebarView = new HQ.IssueShowSidebar model: issue
    @sidebar.setChild(sidebarView)

    @swap view, issue

  clear: ->
    @sidebar.child = null
