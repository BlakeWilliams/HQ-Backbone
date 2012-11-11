class HQ.NewIssue extends Backbone.View
  template: JST['issues/new']

  events:
    'click .save': 'save'
    'click .cancel': 'cancel'

  initialize: ->
    HQ.router.layout.sidebar.updateProject()
    HQ.router.layout.sidebar.setChild()
    @model.on 'error', (model, response, options) =>
      @errors = JSON.parse(response.responseText)
      @render()

  render: ->
    $(@el).html @template(issue: @model)
    @renderErrors()

  renderErrors: ->
    for error of @errors
      $('#' + error).addClass('error')

  save: (e) ->
    e.preventDefault()
    attributes = 
      name: $('#name').val()
      description: $('#description').val()
    console.log @model.url()
    @model.save attributes, 
      success: =>
        @errors = false
        HQ.projects.add @model
        HQ.router.navigate "/projects/#{@model.get 'project_id'}/issues/#{@model.get 'id'}", true
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

