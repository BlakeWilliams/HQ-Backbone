class HQ.Collections.Issues extends HQ.Collection
  model: HQ.Models.Issue
  url: '/issues'

  initialize: ->
    @filterBy = 'open'

  comparator: (a, b) ->
    if a.date().getTime() == b.date().getTime()
      if a.id > b.id
        1
      else
        -1
    else if a.date().getTime() < b.date().getTime()
      1
    else if a.date().getTime() > b.date().getTime()
      -1

  open: ->
    @where status: 'open'

  resolved: ->
    @where status: 'resolved'

  today: ->
    date = new Date()
    month = date.getMonth() + 1
    month = '0' + month.toString() if month.toString().length == 1
    #console.log "#{month}/#{date.getDate()}/#{date.getFullYear()}"
    @where due: "#{month}/#{date.getDate()}/#{date.getFullYear()}", status: 'open'

  overdue: ->
    date = new Date()
    @filter (issue) ->
      date.setDate(new Date().getDate() - 1);
      (issue.date().getTime() < date.getTime()) && issue.get('status') != 'resolved'

  setFilter: (filter) ->
    @filterBy = filter
    @trigger 'change'

  filtered: (filter=null) ->
    filter = @filterBy unless filter
    switch filter
      when "open" then @open()
      when "resolved" then @resolved()
      when "today" then @today()
      when "overdue" then @overdue()
      else @models
