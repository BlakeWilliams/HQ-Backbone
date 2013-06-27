HQ.Routers.Users =
  gotoLogin: (options = {}) ->
    view = new HQ.Views.Login
    @navigate "/login"
    @swap view

  login: ->
    @gotoLogin()
