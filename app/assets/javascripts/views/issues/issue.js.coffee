class HQ.Views.Issue extends Backbone.View
  template: JST['issues/show']

  initialize: ->
    @commentFormView = new HQ.Views.CommentForm issue: @model
    @issueDetails    = new HQ.Views.IssueDetails model: @model

    @commentFormView.parent = this
    @issueDetails.parent = this

    @model.fetch()

  render: ->
    @$el.html @template(issue: @model)

    @commentFormView.setElement @$el.find('#new-comment')
    @commentFormView.render()

    @renderDetails()

  renderDetails: ->
    @issueDetails.setElement @$el.find('#issue-details')
    @issueDetails.render()

  leave: ->
    @commentFormView._destroy()
    @issueDetails._destroy()

