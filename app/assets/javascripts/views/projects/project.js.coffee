HQ.Views.Project = HQ.View.extend
  template: JST['projects/project']
  issuesTemplate: JST['projects/_issues']
  newIssueTemplate: JST['issues/new']

  events:
    'click .new-issue': 'newIssue'
    'click .delete': 'delete'

  initialize: (options) ->
    @issueViews = []
    @filter = 'open'
    @model.on 'change', @renderIssues, this

    @poll = setInterval =>
      @model.fetch()
    , 10000
  
  render: ->
    $(@el).html @template
      project: @model

    @detailView = new HQ.Views.ProjectDetails 
      el: $(@el).find('#project-details')
      model: @model
    @detailView.render()

    @actionsView = new HQ.Views.ProjectActions
      el: $(@el).find('#actions')
      model: @model
    @actionsView.parent = this
    @actionsView.render()

    this


  renderIssues: ->
    $(@el).find('#issues').html @issuesTemplate
      filter: @filter
      project: @model

    @cleanUpIssues()

    for issue in @model.issues.filtered(@filter)
      view = new HQ.Views.ProjectIssue(model: issue)
      view.parent = this
      @issueViews.push(view)
      $(@el).find('#issue-list').append view.render().el

  cleanUpIssues: ->
    for view in @issueViews
      view._destroy()

  newIssue: (e) ->
    e.preventDefault()
    issue = new HQ.Models.Issue(project: @model)
    view = new HQ.Views.NewIssue
      model: issue
      el: $(@el).find('#new-issue')
    view.render()

  delete: (e) ->
    e.preventDefault()
    if confirm("Are you sure you want to delete this project?")
      @model.destroy()
      HQ.projects.remove(@model)
      HQ.router.gotoProjects()

  leave: ->
    clearInterval @poll
