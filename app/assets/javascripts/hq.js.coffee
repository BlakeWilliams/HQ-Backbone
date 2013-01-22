$(document).ajaxError (e, xhr, options) ->
  if xhr.responseText == "unauthenticated"
    HQ.router.gotoLogin()

HQ.View = Backbone.View.extend
  _destroy: ->
    @leave() if @leave
    @unbind()

HQ.Model = Backbone.Model.extend
  constructor: (attributes, options) ->
    @isLoaded = false
    @once 'change', @_isLoaded, this
    Backbone.Model.apply(this, arguments)

  _isLoaded: ->
    @isLoaded = true
    @trigger 'loaded'

HQ.Collection = Backbone.Collection.extend
  constructor: (attributes, options) ->
    @isLoaded = false
    @once 'sync', @_isLoaded, this
    @once 'reset', @_isLoaded, this
    @once 'add', @_isLoaded, this
    Backbone.Collection.apply(this, arguments)

  _isLoaded: ->
    @isLoaded = true
    @trigger 'loaded'
