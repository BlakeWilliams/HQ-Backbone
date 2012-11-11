class HQ.Router extends Backbone.Router
  routes:
    '': 'projectIndex'
    'projects': 'projectIndex'
    'projects/new': 'newProject'
    'projects/:id': 'showProject'
    'projects/:id/issues/new': 'newIssue'

  initialize: ->
    if !HQ.projects
      HQ.projects = new HQ.Projects()
      HQ.projects.fetch()
    @layout = new HQ.Layout()
    @layout.sidebar = new HQ.Sidebar collection: HQ.projects
    $('body').html @layout.render().el

  swap: (child, object) =>
    @layout.child._destroy if @layout.child
    @layout.child = child
    if object
      object.fetch
        success: =>
          @layout.renderChild()
    else
      @layout.renderChild()

  projectIndex: ->
    projects = HQ.projects
    view = new HQ.ProjectIndex collection: projects
    @swap view, projects

  showProject: (id) ->
    project = HQ.projects.get(id) || new HQ.Project {id: id}
    view = new HQ.ProjectShow model: project
    @swap view, project

  newProject: ->
    project = new HQ.Project()
    view = new HQ.ProjectNew model: project
    @swap view

  newIssue: (id) ->
    project = HQ.projects.get(id) || new HQ.Project {id: id}
    project.fetch()
    issue = new HQ.Issue project: project
    view = new HQ.NewIssue model: issue
    @swap view

  clear: ->
    @layout.sidebar.child = null
