class HQ.ProjectIndex extends Backbone.View
  template: JST['projects/index']

  events: ->
    'click h1 a': 'gotoProject'

  initialize: (options) ->
    HQ.router.layout.sidebar.updateProject()
    HQ.router.layout.sidebar.setChild(new HQ.ProjectIndexSidebar())
    @collection.bind 'reset', @render, this

  render: ->
    $(@el).html @template(projects: @collection)
    this

  gotoProject: (e) ->
    e.preventDefault()
    HQ.router.navigate $(e.currentTarget).attr('href'), true
