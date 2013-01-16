HQ.Views.ProjectIssue = HQ.View.extend
  template: JST['projects/_issue']
  className: 'issue'

  initialize: ->
    @model.on 'change', @render, this

  events:
    'click .issue-name a': 'gotoIssue'
    'click .toggle': 'toggle'

  render: ->
    $(@el).html @template
      issue: @model
      statusClass: @issueStatus()
      #this
      
  gotoIssue: (e) ->
    e.preventDefault() 
    HQ.router.gotoIssue @model

  issueStatus: ->
    if @model.resolved()
      return 'resolved'
    else if @model.today()
      return 'today'
    else if @model.overdue()
      return 'overdue'
    else
      return 'open'

  toggle: ->
    @model.toggleStatus()
    @parent.renderChildren()
