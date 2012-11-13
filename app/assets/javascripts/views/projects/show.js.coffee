class HQ.ProjectShow extends Backbone.View
  template: JST['projects/show']

  events:
    'click .issue-name a': 'gotoIssue'

  initialize: (options) ->
    @model.on 'change', @render, this
  
  render: ->
    $(@el).html @template(project: @model)
    this

  gotoIssue: (e) ->
    e.preventDefault() 
