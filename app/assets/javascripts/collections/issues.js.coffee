class HQ.Collections.Issues extends Backbone.Collection
  model: HQ.Models.Issue
  url: '/issues'

  open: ->
