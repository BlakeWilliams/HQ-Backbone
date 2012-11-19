class HQ.Models.Comment extends Backbone.Model
  url: ->
    base = "/issues/#{@get 'issue_id'}/comments"
    return base if @isNew()
    "#{base}/#{@get 'id'}"
