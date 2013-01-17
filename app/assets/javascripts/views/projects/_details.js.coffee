HQ.Views.ProjectDetails = HQ.View.extend
  template: JST['projects/_details']

  events:
    'dblclick .title': 'toggleTitleEdit'
    'focusout .title-input': 'stopEdit'
    'keydown .title-input': 'titleKeyDown'

  render: ->
    $(@el).html @template
      project: @model
      editTitle: @editTitle
      editDescription: @editDescription

    $('.title-input').focus()

  toggleTitleEdit: ->
    @editTitle = true
    @render()

  saveTitle: ->
    value = $('.title-input').val()
    if @model.get('name') != value
      @model.set('name', value)
      @model.save()

  titleKeyDown: (e) ->
    code = e.keyCode || e.which
    if code == 13
       @saveTitle()
       @stopEdit()
     else if code == 27
       @stopEdit()

  stopEdit: ->
    @editTitle = false
    @editDescription = false
    @render()
