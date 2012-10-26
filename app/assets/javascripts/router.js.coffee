class HQ.Router extends Backbone.Router
  routes:
    '': 'index'
    'projects': 'index'
    'projects/new': 'new'
    'projects/:id': 'show'

  initialize: ->
    @layout = new HQ.Views.Layout()
    @layout.sidebar = new HQ.Views.Sidebar()
    $('body').html @layout.render().el

  swap: (child, object) =>
    @layout.child = child
    if object
      object.fetch
        success: =>
          @layout.renderChild()
    else
      @layout.renderChild()

  index: ->
    projects = new HQ.Collections.Projects()
    view = new HQ.Views.ProjectIndex collection: projects
    @swap view, projects

  show: (id) ->
    project = new HQ.Models.Project {id: id}
    view = new HQ.Views.ProjectShow model: project
    @swap view, project

  new: ->
    project = new HQ.Models.Project()
    view = new HQ.Views.ProjectNew model: project
    @swap view

  clear: ->
    @layout.sidebar.child = null
