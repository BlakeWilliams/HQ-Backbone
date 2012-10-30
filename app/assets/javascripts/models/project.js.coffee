class HQ.Project extends Backbone.Model
  initialize: ->
    @on 'change', @updateIssues
    @issues = new HQ.Issues()

  url: ->
    "/projects/#{@get 'id'}" 

  updateIssues: ->
    @issues.add @get('issues') if @get('issues')

  validate: (attrs, options) ->
    errors = {}
    if !attrs.name || (attrs.name && attrs.name.length <= 1)
      errors['name'] = 'Name must be at least 2 characters'

    return errors if errors.length != undefined
    return null
