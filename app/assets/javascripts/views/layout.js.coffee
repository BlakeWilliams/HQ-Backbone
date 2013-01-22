class HQ.Views.Layout extends HQ.View
  template: Handlebars.templates['layout']

  initialize: ->
    @showLayout = true

  events:
    'click header h1': 'goHome'
    'click .hq-link': 'gotoLink'

  render: ->
    $(@el).html @template
    @renderChild() if @child
    @renderSidebar() if @showLayout
    this

  renderChild: ->
    if @showLayout
      @child.setElement(@$('#outlet')).render()
    else
      @child.setElement(@$('#container')).render()

  renderSidebar: ->
    @sidebar.setElement(@$('#sidebar')).render()

  toggleLayout: (option) ->
    if option != undefined
      @showLayout = option
    else
      @showLayout = !@showLayout
    @render()

  goHome: ->
    HQ.router.navigate '/', true

  gotoLink: (e) ->
    e.preventDefault()
    target = $(e.currentTarget)
    HQ.router.navigate target.attr('href'), true
