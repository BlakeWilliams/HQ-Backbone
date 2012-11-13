class HQ.Issue extends Backbone.Model
  initialize: (options) ->
    @set 'project_id', options.project.get('id') if options.project
    @set 'project', options.project if options.project

    if !@get('project')
      @set 'project', new HQ.Project(id: @get('project_id'))
      @get('project').fetch()

  url: ->
    base = "/projects/#{@get('project_id')}/issues"
    return base if @isNew()
    "#{base}/#{@get 'id'}"

  urlRoot: ->
    "/projects/#{@get('project_id')}"
