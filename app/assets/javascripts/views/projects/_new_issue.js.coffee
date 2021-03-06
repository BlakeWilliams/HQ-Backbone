HQ.Views.NewIssue = HQ.View.extend
  template: Handlebars.templates['projects/_new_issue']

  events:
    'click .new-issue': 'toggle'
    'click .save': 'save'
    'click .cancel': 'cancel'

  initialize: ->
    @toggled = false

    @model.on 'error', (model, response, options) =>
      @errors = JSON.parse(response.responseText)
      @render()

  render: ->
    $(@el).html @template
      toggled: @toggled

    $('#date').datepicker
      constrainInput: true
      dateFormat: 'mm/dd/yy'
      minDate: 0
    @renderErrors()

  renderErrors: ->
    for error of @errors
      $('#' + error).addClass('error')

  toggle: (e) ->
    e.preventDefault()
    @toggled = true
    @render()

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
        @model = new HQ.Models.Issue(project: @model.project)
        @cancel()
      error: =>
        @$el.find('.save').removeAttr 'disabled'

  cancel: (e) ->
    e.preventDefault() if e
    @toggled = false
    @render()
