class Backbone.View extends Backbone.View
  _destroy: ->
    @unbind()
    @leave() if @leave
    @model.off(null, null, this) if @model
    @collection.off(null, null, this) if @model
    @destroy() if @destroy
