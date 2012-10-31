#= require jquery
#= require underscore
#= require backbone
#= require_self
#= require hq
#= require ./router
#= require_tree ../templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views

window.HQ =
  init: ->
    HQ.router = new HQ.Router()
    Backbone.history.start()

$ ->
  HQ.init()

