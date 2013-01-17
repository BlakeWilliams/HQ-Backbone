HQ.Views.ProjectActions = HQ.View.extend
  template: JST['projects/_actions']

  events:
    'click .action': 'changeFilter'

  render: ->
    $(@el).html @template
      project: @model
      filter: @parent.filter

  changeFilter: (e) ->
    e.preventDefault()
    @parent.filter = $(e.currentTarget).data('name')
    @parent.renderIssues()
    @render()

