class HQ.Sidebar extends Backbone.View
  template: JST['sidebar']

  initialize: ->
    @collection = new HQ.Projects()
    @collection.fetch()
    @collection.on 'reset', @render, this

    @updateProject()

  events:
    'click #project-select': 'toggleProjects'
    'click .sidebar-project a': 'gotoProject'

  render: ->
    $(@el).html(@template {
      projects: @collection,
      projectName: @projectName
      showActions: @showActions
      showProjects: @showList
    })

    @child.setElement(@$('#actions')).render() if @child
    this

  setChild: (child) =>
    @child = child
    @render()

  toggleProjects: ->
    if @showList
      @showList = false
    else
      @showList = true
    @render()

  gotoProject: (e) ->
    e.preventDefault()
    HQ.router.navigate $(e.currentTarget).attr('href'), true
    @toggleProjects()

  updateProject: (projectName = "All Projects") =>
    @projectName = projectName
    @render()

  toggleActions: (value) ->
    if value == true
      @showActions = true
    else
      @showActions = false
    @render()
