class HQ.ProjectShowSidebar extends Backbone.View
  template: JST['projects/_show_sidebar']

  events:
    'click .delete': 'delete'
    'click .new-issue': 'newIssue'
  
  render: ->
    $(@el).html @template
    this

  delete: ->
    console.log 'Destroy the project'

  newIssue: (e) ->
    e.preventDefault()
    HQ.router.navigate "/projects/#{@model.get('id')}/issues/new", true
