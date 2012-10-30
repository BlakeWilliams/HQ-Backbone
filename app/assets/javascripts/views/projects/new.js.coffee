class HQ.ProjectNew extends Backbone.View
  template: JST['projects/new']

  events:
    'click .save': 'save'
    'click .cancel': 'cancel'

  initialize: ->
    HQ.router.layout.sidebar.updateProject()
    HQ.router.layout.sidebar.setChild()

  render: ->
    $(@el).html @template()


  save: (e) ->
    e.preventDefault()
    attributes = 
      name: $('#name').val()
      description: $('#description').val()
    console.log 'save'
    @model.save attributes, 
      success: ->
        console.log 'success'
        HQ.router.navigate '/projects', true
      error: (m, err) ->
        console.log m, err
        for attr of attributes
          attribute = $("##{attr}")
          if err[attr]
            attribute.addClass('error')
          else
            attribute.removeClass('error')

  cancel: (e) ->
    e.preventDefault()
    HQ.router.navigate $(e.currentTarget).attr('href'), true
