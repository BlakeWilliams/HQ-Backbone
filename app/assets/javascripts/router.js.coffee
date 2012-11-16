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

    @layout = new HQ.Layout()
    @sidebar = new HQ.Sidebar collection: HQ.projects
    @layout.sidebar = @sidebar

    $('body').html @layout.render().el

  swap: (child, object, projectName) =>
    @layout.child._destroy if @layout.child
    @layout.child = child

    @layout.renderChild()
    object.fetch
      success: => @layout.renderChild()

    # Set project name here
    @sidebar.updateProject object


  newIssue: (id) ->
    project = HQ.projects.get(id) || new HQ.Project {id: id}
    project.fetch()
    issue = new HQ.Issue project: project
    view = new HQ.NewIssue model: issue
    @swap view, issue
  
  showIssue: (project_id, id) ->
    issue = new HQ.Issue id: id, project_id: project_id
    view = new HQ.IssueShow model: issue

    @swap view, issue

console.log HQ.ProjectRoutes
_.extend HQ.Router.prototype, HQ.ProjectRoutes
