class HQ.Issue extends Backbone.Model
  initialize: (options) ->
    @set 'project_id', options.project.get('id') if options.project
    console.log @get('id')

  url: ->
    base = "/projects/#{@get('project_id')}/issues"
    return base if @isNew()
    "#{base}/#{@get 'id'}"
