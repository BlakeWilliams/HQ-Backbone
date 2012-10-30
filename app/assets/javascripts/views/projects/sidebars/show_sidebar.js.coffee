class HQ.ProjectShowSidebar extends Backbone.View
  template: JST['projects/_show_sidebar']
  
  render: ->
    $(@el).html @template
    this
