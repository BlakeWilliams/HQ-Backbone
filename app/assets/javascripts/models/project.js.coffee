class HQ.Models.Project extends Backbone.Model
  url: ->
    "/projects/#{@get 'id'}" 
