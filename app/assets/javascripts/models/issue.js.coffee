class HQ.Issue extends Backbone.Model
  initialize: (options) ->
    @set 'project_id', options.project.get('id') if options.project
    @set 'project', options.project if options.project

  url: ->
    base = "/projects/#{@get('project_id')}/issues"
    return base if @isNew()
    "#{base}/#{@get 'id'}"

  resolved: ->
    @get('status') == "resolved"

  open: ->
    @get('status') == "open"

  setStatus: (status) ->
    @set 'status', status
    @save()
