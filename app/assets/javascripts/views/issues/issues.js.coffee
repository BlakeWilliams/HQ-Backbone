class HQ.Views.Issues extends HQ.View
  template: JST['issues/issues']

  initialize: ->

  render: ->
    @$el.html @template(issues: @collection)
