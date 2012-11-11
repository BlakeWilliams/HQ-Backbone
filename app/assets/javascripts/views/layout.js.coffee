class HQ.Layout extends Backbone.View
  template: JST['layout']

  events:
    'click header h1': 'goHome'

  render: ->
    $(@el).html @template
    @renderChild() if @child
    @renderSidebar()
    this

  renderChild: ->
    @child.setElement(@$('#outlet')).render()

  renderSidebar: ->
    @sidebar.setElement(@$('#sidebar')).render()

  goHome: ->
    HQ.router.navigate '/', true
