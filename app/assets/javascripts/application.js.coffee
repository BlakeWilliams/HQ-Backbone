#= require jquery
#= require jquery-ui
#= require underscore
#= require backbone
#= require_self
#= require hq
#= require_tree ./routers
#= require ./router
#= require_tree ../templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require md5

window.HQ =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    HQ.router = new HQ.Router()
    Backbone.history.start()

$ ->
  HQ.init()

$(document).ajaxSend (e, xhr, options) ->
  token = $('meta[name="csrf-token"]').attr('content')
  xhr.setRequestHeader('X-CSRF-Token', token)
