class HQ.ProjectNew extends Backbone.View
  template: JST['projects/new']

  events:
    'click .save': 'save'
    'click .cancel': 'cancel'

  initialize: ->
    @model.on 'error', (model, response, options) =>
      @errors = JSON.parse(response.responseText)
      @render()

  render: ->
    $(@el).html @template(project: @model)
    @renderErrors()

  renderErrors: ->
    for error of @errors
      $('#' + error).addClass('error')

  save: (e) ->
    e.preventDefault()
    attributes = 
      name: $('#name').val()
      description: $('#description').val()
    console.log 'save'
    @model.save attributes, 
      success: =>
        HQ.projects.add @model
        HQ.router.navigate '/projects', true
      error: (m, err) ->
        console.log m, err
        for attr of attributes
          attribute = $("##{attr}")
          if err[attr]
            attribute.addClass('error')
          else
            attribute.removeClass('error')

  cancel: (e) ->
    e.preventDefault()
    HQ.router.navigate $(e.currentTarget).attr('href'), true
