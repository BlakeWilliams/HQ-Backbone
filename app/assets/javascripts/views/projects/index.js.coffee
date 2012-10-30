class HQ.ProjectIndex extends Backbone.View
  template: JST['projects/index']

  initialize: (options) ->
    HQ.router.layout.sidebar.updateProject()
    HQ.router.layout.sidebar.setChild(new HQ.ProjectIndexSidebar())
    @collection.bind 'reset', @render, this

  render: ->
    $(@el).html @template(projects: @collection)
    this
