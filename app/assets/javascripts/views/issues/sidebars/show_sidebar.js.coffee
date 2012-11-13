class HQ.IssueShowSidebar extends Backbone.View
  template: JST['issues/_show_sidebar']

  initialize: ->
    @model.on 'change', @render, this

  events:
    'click .resolved': 'resolve'
    'click .open': 'open'
  
  render: ->
    $(@el).html @template(issue: @model)
    this

  resolve: (e) ->
    e.preventDefault()
    @model.setStatus 'resolved' if !@model.resolved()
    @render()

  open: (e) ->
    e.preventDefault()
    @model.setStatus 'open' if !@model.open()
    @render()
