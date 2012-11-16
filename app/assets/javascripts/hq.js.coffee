Backbone.View = Backbone.View.extend
  _destroy: ->
    @unbind()
    @leave() if @leave
    @model.off(null, null, this) if @model
    @collection.off(null, null, this) if @model
    @destroy() if @destroy


oldModel = Backbone.Model
newModel = Backbone.Model.extend
  constructor: (attributes, options) ->
    @isLoaded = false
    @on 'change', @_isLoaded, this
    oldModel.apply(this, arguments)

  _isLoaded: ->
    @isLoaded = true
    @off null, @_isLoaded, this

Backbone.Model = newModel


oldCollection = Backbone.Collection
newCollection = Backbone.Collection.extend
  constructor: (attributes, options) ->
    @isLoaded = false
    @on 'reset', @_isLoaded, this
    @on 'add', @_isLoaded, this
    oldCollection.apply(this, arguments)

  _isLoaded: ->
    @isLoaded = true
    @trigger 'loaded'
    @off null, @_isLoaded, this
    @off null, @_isLoaded, this

Backbone.Collection = newCollection
