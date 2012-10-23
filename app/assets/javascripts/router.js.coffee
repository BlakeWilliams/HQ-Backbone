class HQ.Router extends Backbone.Router
  routes:
    '': 'index'
    'projects': 'index'
    'projects/:id': 'show'

  initialize: ->
    @layout = new HQ.Views.Layout()
    @layout.sidebar = new HQ.Views.Sidebar()
    $('body').html @layout.render().el

  swap: (object, child) =>
    @layout.child.leave() if @layout.child && @layout.child.leave
    @layout.child = child
    object.fetch
      success: =>
        @layout.renderChild()

  index: ->
    projects = new HQ.Collections.Projects()
    view = new HQ.Views.ProjectIndex collection: projects
    @swap projects, view

  show: (id) ->
    project = new HQ.Models.Project {id: id}
    view = new HQ.Views.ProjectShow model: project
    @swap project, view
