class HQ.Views.Layout extends Backbone.View
  template: JST['layout']

  render: ->
    $(@el).html @template
    @renderChild() if @child
    @renderSidebar()
    this

  renderChild: ->
    @$('#outlet').html @child.render().el

  renderSidebar: ->
    @$('#sidebar').html @sidebar.render().el
