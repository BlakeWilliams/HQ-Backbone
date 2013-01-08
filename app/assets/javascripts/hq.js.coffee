$(document).ajaxError (e, xhr, options) ->
  if xhr.responseText == "unauthenticated"
    HQ.router.gotoLogin()

HQ.View = Backbone.View.extend
  _destroy: ->
    @leave() if @leave
    @dispose()

HQ.Model = Backbone.Model.extend
  constructor: (attributes, options) ->
    @isLoaded = false
    @on 'change', @_isLoaded, this
    Backbone.Model.apply(this, arguments)

  _isLoaded: ->
    @isLoaded = true
    @off null, @_isLoaded, this
    @trigger 'loaded'

HQ.Collection = Backbone.Collection.extend
  constructor: (attributes, options) ->
    @isLoaded = false
    @on 'sync', @_isLoaded, this
    @on 'reset', @_isLoaded, this
    @on 'add', @_isLoaded, this
    Backbone.Collection.apply(this, arguments)

  _isLoaded: ->
    @isLoaded = true
    @off null, @_isLoaded, this
    @trigger 'loaded'
