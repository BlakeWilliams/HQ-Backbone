class HQ.IssueShowSidebar extends Backbone.View
  template: JST['issues/_show_sidebar']

  events:
    'click #new-project': 'newProject'
  
  render: ->
    $(@el).html @template
    this

  newProject: (e) ->
    e.preventDefault()
    console.log(e)
    HQ.router.navigate $(e.target).attr('href'), true
