HQ.Views.Project = HQ.View.extend
  template: Handlebars.templates['projects/project']
  issuesTemplate: Handlebars.templates['projects/_issues']
  newIssueTemplate: JST['issues/new']

  initialize: (options) ->
    @issueViews = []
    @model.issues.on 'change', @renderIssues, this
    @model.issues.once 'loaded', @renderIssues, this
    @model.issues.setFilter('open')

    @poll = setInterval =>
      @model.fetch()
    , 10000
  
  render: ->
    $(@el).html @template

    @detailView = new HQ.Views.ProjectDetails 
      el: $(@el).find('#project-details')
      model: @model

    @actionsView = new HQ.Views.ProjectActions
      el: $(@el).find('#actions')
      model: @model

    @newIssueView = new HQ.Views.NewIssue
      el: $(@el).find('#new-issue')
      model: new HQ.Models.Issue {project: @model}

    for child in ['newIssueView', 'actionsView', 'detailView']
      @[child].parent = this
      @[child].render()

    @renderIssues()
    this

  renderIssues: ->
    $(@el).find('#issues').html @issuesTemplate
      project: @model

    @cleanUpIssues()
    filteredIssues = @model.issues.filtered()

    if filteredIssues.length == 0
      $(@el).find('#issue-list').append('<h3>No issues found.</h3>')

    for issue in filteredIssues
      view = new HQ.Views.ProjectIssue(model: issue)
      view.parent = this
      @issueViews.push(view)
      $(@el).find('#issue-list').append view.render().el

  cleanUpIssues: ->
    for view in @issueViews
      view._destroy()
      view.remove()
    @issueViews = []

  leave: ->
    clearInterval @poll
