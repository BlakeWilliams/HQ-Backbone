class HQ.Views.ProjectNew extends HQ.View
  template: JST['projects/new']

  events:
    'click .save': 'save'
    'click .cancel': 'cancel'

  initialize: ->
    @model = new HQ.Models.Project()
    @model.on 'error', (model, response, options) =>
      @errors = JSON.parse(response.responseText)
      @renderErrors()

  render: ->
    $(@el).html @template(project: @model)
    @renderErrors()
    this

  renderErrors: ->
    for error of @errors
      $('#' + error).addClass('error')

  save: (e) ->
    e.preventDefault()
    attributes = 
      name: $('#name').val()
      description: $('#description').val()
    @$el.find('.save').attr 'disabled', 'true'
    @model.save attributes, 
      success: =>
        HQ.projects.add @model
        @parent.render()
        @_destroy()
        @el().empty()
      error: =>
        @$el.find('.save').removeAttr 'disabled'


  cancel: (e) ->
    e.preventDefault()
    @_destroy()
    $(@el).empty()
