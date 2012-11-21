class HQ.Views.IssueDetails extends Backbone.View
  template: JST['issues/_issue_details']

  events: ->
    'click .open': 'open'
    'click .close': 'close'
    'click .delete': 'delete'

  initialize: ->
    @poll = setInterval =>
      @model.fetch()
    , 10000
    @model.on 'change', @render, this

  render: ->
    @$el.html @template(issue: @model)

  open: ->

  close: (e) ->
    e.preventDefault()
    @model.set('status', 'resolved')
    @model.save()

  open: (e) ->
    e.preventDefault()
    @model.set('status', 'open')
    @model.save()

  delete: (e) ->
    e.preventDefault()
    if confirm("Are you sure you want to delete this issue?")
      project = HQ.projects.get @model.get('project_id')
      @model.destroy()
      HQ.router.gotoProject(project)

  leave: ->
    clearInterval @poll
