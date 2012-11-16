class HQ.Sidebar extends Backbone.View
  template: JST['sidebar']

  initialize: ->
    @collection.on 'reset', @render, this
    @collection.on 'add', @render, this
    @collection.on 'remove', @render, this

    @updateProject()

  events:
    'click #project-select': 'toggleProjects'
    'click .sidebar-project a': 'gotoProject'
    'click #actions a': 'goto'

  render: ->
    $(@el).html(@template {
      projects: @collection,
      projectName: @projectName
      showActions: @showActions
      showProjects: @showList
      child: @child
    })
    this


  toggleProjects: ->
    if @showList
      @showList = false
    else
      @showList = true
    @render()


  updateProject: (projectName) =>
    if projectName instanceof HQ.Project
      projectName = projectName.get('name')
    else if projectName instanceof HQ.Issue
      if projectName.get('project') && projectName.get('project').get('name')
        projectName = projectName.get('project').get('name')
      else
        projectName.get('project').fetch
          success: =>
            @updateProject projectName.get('project').get('name')
    else
      projectName = "No Project Selected"

    @projectName = projectName
    @render()

  toggleActions: (value) ->
    if value == true
      @showActions = true
    else
      @showActions = false
    @render()

  gotoProject: (e) ->
    e.preventDefault()
    HQ.router.navigate $(e.currentTarget).attr('href'), true
    @toggleProjects()

  goto: (e) ->
    e.preventDefault()
    HQ.router.navigate $(e.currentTarget).attr('href'), true
