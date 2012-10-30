class HQ.Issue extends Backbone.Model
  url: ->
    "/issues/#{@get 'id'}"
