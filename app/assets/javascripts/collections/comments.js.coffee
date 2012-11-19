class HQ.Collections.Comments extends Backbone.Collection
  model: HQ.Models.Comment
  url: '/comments'

  comparator: (comment) ->
    comment.id
