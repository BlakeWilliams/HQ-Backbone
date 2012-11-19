class HQ.Views.IssueDetails extends Backbone.View
  template: JST['issues/_issue_details']

  initialize: ->
    @poll = setInterval =>
      @model.fetch()
    , 10000
    @model.on 'change', @render, this

  render: ->
    @$el.html @template(issue: @model)

  leave: ->
    clearInterval @poll
