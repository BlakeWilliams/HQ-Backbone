class HQ.Models.Issue extends Backbone.Model
  url: ->
    "/issues/#{@get 'id'}"
