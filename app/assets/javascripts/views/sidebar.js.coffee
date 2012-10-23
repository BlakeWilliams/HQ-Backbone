class HQ.Views.Sidebar extends Backbone.View
  template: JST['sidebar']

  initialize: ->
    @collection = new HQ.Collections.Projects()
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
    if @showList
      @$('#project-list').show() 
      @$('#project-select').addClass('show')
    this

  toggleProjects: ->
    if @showList
      @showList = false
      @$('#project-list').hide()
      @$('#project-select').removeClass('show')
    else
      @showList = true
      @$('#project-list').show()
      @$('#project-select').addClass('show')

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
