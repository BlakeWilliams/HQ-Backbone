HQ.Views.NewIssue = HQ.View.extend
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
    $('#date').datepicker
      constrainInput: true
      dateFormat: 'mm/dd/yy'
      minDate: 0
    @renderErrors()

  renderErrors: ->
    for error of @errors
      $('#' + error).addClass('error')

  save: (e) ->
    e.preventDefault()
    attributes = 
      name: $('#name').val()
      due: $('#date').val()
      description: $('#description').val()

    console.log attributes

    @$el.find('.save').attr 'disabled', 'true'
    @model.save attributes, 
      success: =>
        @model.project.issues.add @model
        @model.project.trigger('change')
        @cancel()
      error: =>
        @$el.find('.save').removeAttr 'disabled'


  cancel: (e) ->
    e.preventDefault() if e
    @_destroy()
    @$el.empty()
