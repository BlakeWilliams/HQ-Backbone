class HQ.Collections.Comments extends HQ.Collection
  model: HQ.Models.Comment
  url: '/comments'

  comparator: (comment) ->
    comment.id
