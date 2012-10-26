class HQ.Views.ProjectNewSidebar extends Backbone.View
  template: JST['projects/_new_sidebar']

  events:
    'click #save': 'save'
    'click #cancel': 'cancel'
  
  render: ->
    $(@el).html @template
    this

  save: (e) ->
    e.preventDefault()
    attributes = 
      name: $('#name').val()
      description: $('#description').val()
    @model.save attributes, 
      success: ->
        console.log 'win'
      error: (m, err) ->
        for attr of attributes
          attribute = $("##{attr}")
          if err[attr]
            attribute.addClass('error')
          else
            attribute.removeClass('error')

  cancel: (e) ->
    e.preventDefault()
    HQ.router.navigate $(e.currentTarget).attr('href'), true
    
