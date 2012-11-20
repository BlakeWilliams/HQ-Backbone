HQ.Views.Project = Backbone.View.extend
  template: JST['projects/project']

  events:
    'click .issue-name a': 'gotoIssue'
    'click .new-issue': 'gotoNewIssue'
    'click .edit': 'toggleEdit'
    'click .cancel': 'cancelEdit'
    'submit #edit': 'save'

  initialize: (options) ->
    @count = 0
    @editMode = false
    @model.on 'change', @render, this
  
  render: ->
    $(@el).html @template
      project: @model
      editMode: @editMode
    this

  gotoIssue: (e) ->
    e.preventDefault() 
    issueID = $(e.currentTarget).data('id')
    HQ.router.gotoIssue @model.issues.get(issueID)

  gotoNewIssue: (e) ->
    e.preventDefault()
    HQ.router.gotoNewIssue(@model.id)

  toggleEdit: (e) ->
    e.preventDefault()
    @editMode = true
    @render()

  cancelEdit: (e) ->
    e.preventDefault()
    @editMode = false
    @render()

  save: (e) ->
    e.preventDefault()
    console.log $('#name').val()
    @model.set 'name', $('#name').val()
    @model.set 'description', $('#description').val()
    @model.save 
    @editMode = false
    @render()
