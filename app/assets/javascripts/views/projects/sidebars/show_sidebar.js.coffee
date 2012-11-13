class HQ.ProjectShowSidebar extends Backbone.View
  template: JST['projects/_show_sidebar']

  events:
    'click .delete': 'delete'
    'click .new-issue': 'newIssue'
  
  render: ->
    $(@el).html @template
    this

  delete: (e) ->
    e.preventDefault()
    if confirm("Are you sure you want to destroy this project?")
      @model.destroy
        success: =>
          HQ.projects.remove(@model)
      HQ.router.navigate '/projects', true

  newIssue: (e) ->
    e.preventDefault()
    HQ.router.navigate "/projects/#{@model.get('id')}/issues/new", true
