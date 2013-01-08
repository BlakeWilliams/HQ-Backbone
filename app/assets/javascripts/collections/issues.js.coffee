class HQ.Collections.Issues extends HQ.Collection
  model: HQ.Models.Issue
  url: '/issues'

  comparator: (a, b) ->
    if a.date() == b.date()
      if a.id > b.id
        1
      else
        -1
    else if a.date() < b.date()
      1
    else if a.date() > b.date()
      -1


  open: ->
    @where status: 'open'

  resolved: ->
    @where status: 'resolved'

  today: ->
    #date = new Date()
    #console.log "#{date.getMonth() + 1}/#{date.getDate()}/#{date.getFullYear()}"
    #@where due: "#{date.getMonth() + 1}/#{date.getDate()}/#{date.getFullYear()}"
    @where due: "Today"

  overdue: ->
    date = new Date()
    @filter (issue) ->
      (issue.date() < date) && issue.get('status') != 'resolved'


  filtered: (filter) ->
    switch filter
      when "open" then @open()
      when "resolved" then @resolved()
      when "today" then @today()
      when "overdue" then @overdue()
      else @models
