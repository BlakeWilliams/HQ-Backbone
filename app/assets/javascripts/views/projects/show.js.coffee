class HQ.ProjectShow extends Backbone.View
  template: JST['projects/show']

  events:
    'click .issue-name a': 'gotoIssue'

  initialize: (options) ->
    @model.on 'change', @render, this
    sidebarView = new HQ.ProjectShowSidebar model: @model
    HQ.router.layout.sidebar.setChild(sidebarView)
  
  render: ->
    HQ.router.layout.sidebar.updateProject @model.get('name')
    $(@el).html @template(project: @model)
    this

  gotoIssue: (e) ->
    e.preventDefault() 
