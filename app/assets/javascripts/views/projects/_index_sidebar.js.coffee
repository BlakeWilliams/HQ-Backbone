class HQ.Views.ProjectIndexSidebar extends Backbone.View
  template: JST['projects/_index_sidebar']

  events:
    'click #new-project': 'newProject'
  
  render: ->
    $(@el).html @template
    this

  newProject: (e) ->
    e.preventDefault()
    console.log(e)
    HQ.router.navigate $(e.target).attr('href'), true

  
