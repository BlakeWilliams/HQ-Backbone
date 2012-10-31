class HQ.Router extends Backbone.Router
  routes:
    '': 'index'
    'projects': 'index'
    'projects/new': 'new'
    'projects/:id': 'show'

  initialize: ->
    @layout = new HQ.Layout()
    @layout.sidebar = new HQ.Sidebar()
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

  index: ->
    projects = new HQ.Projects()
    view = new HQ.ProjectIndex collection: projects
    @swap view, projects

  show: (id) ->
    project = new HQ.Project {id: id}
    view = new HQ.ProjectShow model: project
    @swap view, project

  new: ->
    project = new HQ.Project()
    view = new HQ.ProjectNew model: project
    @swap view

  clear: ->
    @layout.sidebar.child = null
