class HQ.Views.IssueDetails extends Backbone.View
  template: JST['issues/_issue_details']

  events: ->
    'click .open': 'open'
    'click .close': 'close'

  initialize: ->
    @poll = setInterval =>
      @model.fetch()
    , 10000
    @model.on 'change', @render, this

  render: ->
    @$el.html @template(issue: @model)

  leave: ->
    clearInterval @poll

  open: ->

  close: (e) ->
    e.preventDefault()
    @model.set('status', 'resolved')
    @model.save()

  open: (e) ->
    e.preventDefault()
    @model.set('status', 'open')
    @model.save()
