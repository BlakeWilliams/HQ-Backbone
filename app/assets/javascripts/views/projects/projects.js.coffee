HQ.Views.Projects = HQ.View.extend
  template: JST['projects/projects']

  events: ->
    'click h1 a': 'gotoProject'

  initialize: (options) ->
    @collection.bind 'reset', @render, this

  render: ->
    $(@el).html @template(projects: @collection)
    this

  gotoProject: (e) ->
    e.preventDefault()
    HQ.router.navigate $(e.currentTarget).attr('href'), true
