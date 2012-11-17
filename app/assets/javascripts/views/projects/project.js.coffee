HQ.Views.Project = Backbone.View.extend
  template: JST['projects/project']

  events:
    'click .issue-name a': 'gotoIssue'

  initialize: (options) ->
    @model.on 'change', @render, this
  
  render: ->
    $(@el).html @template(project: @model)
    this

  gotoIssue: (e) ->
    e.preventDefault() 
    HQ.router.navigate $(e.currentTarget).attr('href'), true
