class HQ.Models.Issue extends HQ.Model
  initialize: (options) ->
    @set 'project_id', options.project.get('id') if options.project
    @project = options.project if options.project

    @comments = new HQ.Collections.Comments null, issue: this
    @on 'change', @updateComments, this
    @on 'sync', => @comments.trigger('sync')
    @comments.on 'loaded', => @trigger('change')

    @comments.add @get('comments') if @has('comments')

  url: ->
    base = "/projects/#{@get('project_id')}/issues"
    return base if @isNew()
    "#{base}/#{@get 'id'}"

  date: ->
    dateParts = @get('due').split('/')
    new Date(dateParts[2], dateParts[0] - 1, dateParts[1])


  updateComments: ->
    return unless @get('comments')
    @comments.add @get('comments'),
      merge: true
    @set 'comments', null

  resolved: ->
    @get('status') == "resolved"

  open: ->
    @get('status') == "open"

  today: ->
    date = new Date()
    month = date.getMonth() + 1
    month = '0' + month.toString() if month.toString().length == 1
    "#{month}/#{date.getDate()}/#{date.getFullYear()}" == @get('due')

  overdue: ->
    date = new Date()
    @date().getTime() < date.getTime() && @get('status') != 'resolved'


  setStatus: (status) ->
    @set 'status', status
    @save()

  toggleStatus: ->
    if @resolved()
      @set 'status', 'open'
    else
      @set 'status', 'resolved'
    @save()
