HQ.Views.Login = HQ.View.extend
  template: Handlebars.templates['users/login']

  initialize: ->
    @render()

  enter: -> 
    HQ.Layout.toggleLayout(false)
    $('body').addClass('login-body')

  events:
    'keyup #email':  'setGravatar'
    'change #email': 'setGravatar'
    'submit #login': 'submit'

  render: ->
    $(@el).html @template(url: @url)

  setGravatar: (e) ->
    @url = 'http://www.gravatar.com/avatar/' + MD5($('#email').val()) + '.jpg?s=80'
    $('#gravatar').attr 'src', @url

  submit: (e) ->
    e.preventDefault()
    data = $(e.currentTarget).serialize()

    request = $.ajax({
      data: data
      type: 'POST'
      url: '/login'
    })

    request.fail (jqXHR, status) =>
      $('#login input').removeClass('error')
      errors = JSON.parse(jqXHR.responseText)
      for error in errors
        $("##{error}").addClass 'error'

    request.done =>
      HQ.router.gotoProjects()

   leave: ->
     $('body').removeClass('login-body')
     HQ.Layout.toggleLayout true
     console.log 'leave'
