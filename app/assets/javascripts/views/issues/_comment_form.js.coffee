class HQ.Views.CommentForm extends Backbone.View
  template: JST['issues/_comment_form']

  events:
    'submit form': 'save'

  initialize: (options) ->
    @issue = options.issue
    @model = new HQ.Models.Comment(issue_id: @issue.id)

  render: ->
    @$el.html @template(comment: @model)
    @renderErrors()
    this

  renderErrors: ->
    for error of @errors
      $('#' + error).addClass('error')

  save: (e) ->
    e.preventDefault()
    @$('btn').attr 'disabled', true
    @model.save {content: $('#content').val()},
      success: (response) =>
        @issue.comments.add @model
        @model = new HQ.Models.Comment(issue_id: @issue.id)
        @errors = undefined
        @parent.renderDetails()
        @render()
      error: =>
        @errors = JSON.parse(response.responseText)
        @renderErrors()
    @$('btn').removeAttr 'disabled', true
