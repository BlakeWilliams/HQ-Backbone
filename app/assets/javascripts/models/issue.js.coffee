class HQ.Issue extends Backbone.Model
  url: ->
    base = "/isses"
    return base if @isNew()
    "#{base}/#{@get 'id'}"
