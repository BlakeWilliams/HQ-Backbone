class HQ.Router extends Backbone.Router
  routes:
    '': 'projects'
    'projects': 'projects'
    'projects/new': 'newProject'
    'projects/:id': 'project'
    'projects/:project_id/issues/new': 'newIssue'
    'projects/:project_id/issues/:id': 'issue'
    'login': 'login'


    'issues': 'issues'

  initialize: ->
    if !HQ.projects
      HQ.projects = new HQ.Collections.Projects()
      HQ.projects.fetch()

    @layout = HQ.Layout = new HQ.Views.Layout()
    @sidebar = HQ.Sidebar = new HQ.Views.Sidebar collection: HQ.projects
    @layout.sidebar = @sidebar

    $('body').html @layout.render().el

  swap: (child, object, options) =>
    @layout.child._destroy() if @layout.child
    @layout.child = child
    @layout.renderChild()

    child.enter() if child.enter

    object.fetch() if object

    # Set project name here
    @sidebar.updateProject object

_.extend HQ.Router.prototype, HQ.Routers.Projects
_.extend HQ.Router.prototype, HQ.Routers.Issues
_.extend HQ.Router.prototype, HQ.Routers.Users
