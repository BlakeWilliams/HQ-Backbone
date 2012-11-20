HQ.Views.NewIssue = Backbone.View.extend
  template: JST['issues/new']

  events:
    'click .save': 'save'
    'click .cancel': 'cancel'

  initialize: ->
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
    @$el.find('.save').attr 'disabled', 'true'
    @model.save attributes, 
      success: =>
        HQ.projects.add @model
        console.log @model.url
        HQ.router.navigate @model.url(), true
      error: =>
        @$el.find('.save').removeAttr 'disabled'


  cancel: (e) ->
    e.preventDefault()
    HQ.router.navigate $(e.currentTarget).attr('href'), true

