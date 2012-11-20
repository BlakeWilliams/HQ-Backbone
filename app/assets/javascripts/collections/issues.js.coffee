class HQ.Collections.Issues extends Backbone.Collection
  model: HQ.Models.Issue
  url: '/issues'

  open: ->
    @where status: 'open'

  resolved: ->
    @where status: 'resolved'
