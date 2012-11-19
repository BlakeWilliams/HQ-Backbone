class HQ.Models.Issue extends Backbone.Model
  initialize: (options) ->
    @set 'project_id', options.project.get('id') if options.project
    @set 'project', options.project if options.project

    @comments = new HQ.Collections.Comments null, issue: this
    @on 'change', @updateComments, this
    @on 'sync', => @comments.trigger('sync')
    #@comments.on 'loaded', => @trigger('change')
    @on 'change', console.log 'changed'

  url: ->
    base = "/projects/#{@get('project_id')}/issues"
    return base if @isNew()
    "#{base}/#{@get 'id'}"

  updateComments: ->
    return unless @get('comments')
    comments = _.reject @get('comments'), (comment) =>
      return true if @comments.get(comment.id)
      false
    @comments.add comments

  resolved: ->
    @get('status') == "resolved"

  open: ->
    @get('status') == "open"

  setStatus: (status) ->
    @set 'status', status
    @save()
