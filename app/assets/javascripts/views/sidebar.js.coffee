class HQ.Views.Sidebar extends HQ.View
  template: JST['sidebar']

  initialize: ->
    @collection.on 'reset', @render, this
    @collection.on 'add', @render, this
    @collection.on 'remove', @render, this

    @updateProject()

  events:
    'click #project-select': 'toggleProjects'
    'click .sidebar-project a': 'gotoProject'
    'click h4 a': 'goto'

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

  setName: (name) ->
    @projectName = name
    @render()


  updateProject: (obj) =>
    if obj instanceof HQ.Models.Project
      @setName obj.get('name')
    else if obj instanceof HQ.Models.Issue
      if obj.get('project')
        @setName obj.get('project').get('name')
        console.log 'here'
      else
        project = new HQ.Models.Project id: obj.get('project_id')
        project.fetch
          success: => @setName project.get('name')
    else
      @setName "No Project Selected"

  toggleActions: (value) ->
    if value == true
      @showActions = true
    else
      @showActions = false
    @render()

  gotoProject: (e) ->
    e.preventDefault()
    HQ.router.gotoProject @collection.get $(e.currentTarget).attr('href')
    @toggleProjects()

  goto: (e) ->
    e.preventDefault()
    HQ.router.navigate $(e.currentTarget).attr('href'), true
