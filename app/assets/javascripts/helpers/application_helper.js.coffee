Handlebars.registerHelper 'linkTo', (text, options) ->

  text = Handlebars.Utils.escapeExpression(text)
  options.hash.href = Handlebars.Utils.escapeExpression(options.hash.href)

  path = "##{options.hash.href}"
  path += "/#{options.hash.id}" if options.hash.id

  new Handlebars.SafeString("""<a href="#{path}" class="hq-link">#{text}</a>""")

Handlebars.registerHelper 'put', (text, options) ->
  return text if !options.hash.if
  if typeof(options.hash.if) == "function"
    return if !options.hash.if.call()
  else if !options.hash.if
    return
  return text
