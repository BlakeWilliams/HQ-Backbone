class HQ.Router extends Backbone.Router
  routes:
    '': 'projects'
    'projects': 'projects'
    'projects/new': 'newProject'
    'projects/:id': 'project'
    'projects/:project_id/issues/new': 'newIssue'
    'projects/:project_id/issues/:id': 'issue'

  initialize: ->
    if !HQ.projects
      HQ.projects = new HQ.Collection.Projects()
      HQ.projects.fetch()

    @layout = new HQ.Views.Layout()
    @sidebar = new HQ.Views.Sidebar collection: HQ.projects
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
    project = HQ.projects.get(id) || new HQ.Models.Project {id: id}
    project.fetch()
    issue = new HQ.Models.Issue project: project
    view = new HQ.Views.NewIssue model: issue
    @swap view, issue
  
  issue: (project_id, id) ->
    issue = new HQ.Models.Issue id: id, project_id: project_id
    view = new HQ.Views.Issue model: issue

    @swap view, issue

_.extend HQ.Router.prototype, HQ.Routers.ProjectRoutes
