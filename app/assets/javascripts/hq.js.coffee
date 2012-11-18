Backbone.View = Backbone.View.extend
  _destroy: ->
    @leave() if @leave
    @dispose()


oldModel = Backbone.Model
newModel = Backbone.Model.extend
  constructor: (attributes, options) ->
    @isLoaded = false
    @on 'change', @_isLoaded, this
    oldModel.apply(this, arguments)

  _isLoaded: ->
    @isLoaded = true
    @off null, @_isLoaded, this
    @trigger 'loaded'

Backbone.Model = newModel


oldCollection = Backbone.Collection
newCollection = Backbone.Collection.extend
  constructor: (attributes, options) ->
    @isLoaded = false
    @on 'sync', @_isLoaded, this
    @on 'reset', @_isLoaded, this
    @on 'add', @_isLoaded, this
    oldCollection.apply(this, arguments)

  _isLoaded: ->
    @isLoaded = true
    @off null, @_isLoaded, this
    @trigger 'loaded'

Backbone.Collection = newCollection
