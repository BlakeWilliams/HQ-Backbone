HQ.Views.ProjectIssue = HQ.View.extend
  template: Handlebars.templates['projects/_issue']
  tagName: 'tr'
  className: 'issue'

  initialize: ->
    @model.on 'change', @render, this

  events:
    'click .toggle': 'toggle'

  render: ->
    $(@el).html @template
      issue: @model
    this
      
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
    console.log @
    @model.toggleStatus()
    @parent.actionsView.render()
