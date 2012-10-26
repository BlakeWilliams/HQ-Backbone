class HQ.Views.Layout extends Backbone.View
  template: JST['layout']

  render: ->
    $(@el).html @template
    @renderChild() if @child
    @renderSidebar()
    this

  renderChild: ->
    @child.setElement(@$('#outlet')).render()

  renderSidebar: ->
    @sidebar.setElement(@$('#sidebar')).render()
