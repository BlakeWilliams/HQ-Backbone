class HQ.Views.Issues extends Backbone.View
  template: JST['issues/issues']

  initialize: ->

  render: ->
    @$el.html @template(issues: @collection)
