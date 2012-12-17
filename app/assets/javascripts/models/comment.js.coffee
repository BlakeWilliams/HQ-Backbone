class HQ.Models.Comment extends HQ.Model
  url: ->
    base = "/issues/#{@get 'issue_id'}/comments"
    return base if @isNew()
    "#{base}/#{@get 'id'}"
