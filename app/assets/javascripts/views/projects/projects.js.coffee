HQ.Views.Projects = HQ.View.extend
  template: Handlebars.templates['projects/projects']
  projectsTemplate: Handlebars.templates['projects/_projects']
  newProjectTemplate: JST['projects/new']

  events: ->
    'click #new-project-btn': 'newProject'

  initialize: (options) ->
    @collection.bind 'reset', @render, this

  render: ->
    $(@el).html @template
      projects: @collection.models

    @renderProjects()
    this

  renderProjects: ->
    $(@el).find('#projects').html @projectsTemplate
      projects: @collection.models

  gotoProject: (e) ->
    e.preventDefault()
    HQ.router.navigate $(e.currentTarget).attr('href'), true

  newProject: (e) ->
    @project = new HQ.Views.ProjectNew(el: $(@el).find('#new-project'))
    @project.parent = this
    @project.render()

  leave: ->
    @project._destroy() if @project
