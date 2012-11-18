HQ.Views.Project = Backbone.View.extend
  template: JST['projects/project']

  events:
    'click .issue-name a': 'gotoIssue'

  initialize: (options) ->
    @count = 0
    @model.on 'change', @render, this
  
  render: ->
    $(@el).html @template(project: @model)
    this

  gotoIssue: (e) ->
    console.log @count
    @count += 1
    e.preventDefault() 
    issueID = $(e.currentTarget).data('id')
    HQ.router.gotoIssue @model.issues.get(issueID)
