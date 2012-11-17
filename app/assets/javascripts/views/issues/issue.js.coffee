class HQ.Views.Issue extends Backbone.View
  template: JST['issues/show']

  initialize: ->
    @model.on 'change', @render, this
    @model.fetch()

  render: ->
    @$el.html @template(issue: @model)

