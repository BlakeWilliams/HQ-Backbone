class HQ.Views.ProjectNew extends Backbone.View
  template: JST['projects/new']

  initialize: ->
    HQ.router.layout.sidebar.updateProject()
    HQ.router.layout.sidebar.setChild(new HQ.Views.ProjectNewSidebar(model: @model))

  render: ->
    $(@el).html @template()
