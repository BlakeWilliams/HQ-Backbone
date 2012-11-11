class HQ.Project extends Backbone.Model
  initialize: ->
    @on 'change', @updateIssues
    @issues = new HQ.Issues()

  url: ->
    base = "/projects"
    return base if @isNew()
    "#{base}/#{@get 'id'}"

  updateIssues: ->
    @issues.add @get('issues') if @get('issues')

  validate: (attrs, options) ->
    errors = {}
    if !attrs.name || (attrs.name && attrs.name.length >= 2 && attrs.name.length <= 22)
      errors['name'] = 'Name must be between 2 and 22 characters'

    return errors if errors.length != undefined
    return null
