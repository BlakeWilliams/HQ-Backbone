HQ.Views.ProjectActions = HQ.View.extend
  template: Handlebars.templates['projects/_actions']

  initialize: ->
    @model.on 'change', @render, this
    @model.issues.on 'reset', @render, this

  events:
    'click .action': 'changeFilter'

  render: ->
    $(@el).html @template
      project: @model

  changeFilter: (e) ->
    e.preventDefault()
    @model.issues.setFilter $(e.currentTarget).data('name')
    HQ.router.navigate @model.url() + "/#{@model.issues.filterBy}"
    @render()

