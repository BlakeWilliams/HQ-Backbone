HQ.Views.Project = HQ.View.extend
  template: JST['projects/project']
  actionsTemplate: JST['projects/_actions']
  issuesTemplate: JST['projects/_issues']
  detailsTemplate: JST['projects/_details']
  newIssueTemplate: JST['issues/new']

  events:
    'click .issue-name a': 'gotoIssue'
    'click .new-issue': 'newIssue'
    'click .action': 'changeFilter'
    'click .delete': 'delete'

  initialize: (options) ->
    @filter = 'open'
    @model.on 'change', @renderChildren, this

    @poll = setInterval =>
      @model.fetch()
    , 10000
  
  render: ->
    $(@el).html @template
      project: @model
      editMode: @editMode

    @renderChildren()
    this

  renderChildren: ->
    $(@el).find('#project-details').html @detailsTemplate
      project: @model

    $(@el).find('#actions').html @actionsTemplate
      filter: @filter
      project: @model

    @renderIssues()


  renderIssues: ->
    $(@el).find('#issues').html @issuesTemplate
      filter: @filter
      project: @model

  gotoIssue: (e) ->
    e.preventDefault() 
    issueID = $(e.currentTarget).data('id')
    HQ.router.gotoIssue @model.issues.get(issueID)

  newIssue: (e) ->
    e.preventDefault()
    issue = new HQ.Models.Issue(project: @model)
    view = new HQ.Views.NewIssue
      model: issue
      el: $(@el).find('#new-issue')

    view.render()

  save: (e) ->
    e.preventDefault()

    @model.save 
      name: $('#name').val()
      description: $('#description').val()
    , 
      patch: true

    @editMode = false
    @render()

  delete: (e) ->
    e.preventDefault()
    if confirm("Are you sure you want to delete this project?")
      @model.destroy()
      HQ.projects.remove(@model)
      HQ.router.gotoProjects()

  changeFilter: (e) ->
    e.preventDefault()
    @filter = $(e.currentTarget).data('name')
    @renderChildren()


  leave: ->
    clearInterval @poll
