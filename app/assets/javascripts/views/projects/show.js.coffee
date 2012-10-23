class HQ.Views.ProjectShow extends Backbone.View
  template: JST['projects/show']

  initialize: (options) ->
    @model.on 'change', @render, this
  
  render: ->
    HQ.router.layout.sidebar.updateProject @model.get('name')
    HQ.router.layout.sidebar.toggleActions(true)
    $(@el).html @template(project: @model)
    this
