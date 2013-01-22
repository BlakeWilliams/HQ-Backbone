Handlebars.registerHelper 'filterLink', (text, project) ->
  lowerText = text.toLowerCase()
  current = if lowerText == project.issues.filterBy then true else false

  text += " #{project.issues.filtered(lowerText).length}"

  classes = "btn action #{lowerText} #{'red current' if current}"
  new Handlebars.SafeString("""<a data-name="#{lowerText}" class="#{classes}">#{text}</a>""")
