class Backbone.View extends Backbone.View
  _destroy: ->
    @unbind()
    @leave() if @leave
