HQ.Routers.Users =
  gotoLogin: ->
    view = new HQ.Views.Login
    @swap view

  login: ->
    @gotoLogin()
