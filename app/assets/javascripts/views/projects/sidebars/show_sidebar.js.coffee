class HQ.ProjectShowSidebar extends Backbone.View
  template: JST['projects/_show_sidebar']

  events:
    'click .delete': 'destroy'
  
  render: ->
    $(@el).html @template
    this
