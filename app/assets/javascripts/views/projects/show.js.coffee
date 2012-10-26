class HQ.Views.ProjectShow extends Backbone.View
  template: JST['projects/show']

  initialize: (options) ->
    @model.on 'change', @render, this
    console.log 'init'
    HQ.router.layout.sidebar.setChild(new HQ.Views.ProjectShowSidebar())
  
  render: ->
    HQ.router.layout.sidebar.updateProject @model.get('name')
    $(@el).html @template(project: @model)
    this
