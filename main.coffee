Jsfmt = require './lib/jsfmt'

module.exports =

  # Configuration
  configDefaults:
    pathToJsfmt: '/usr/local/bin/jsfmt' # Where the jsfmt binary is located
    showErrors: true # Whether or not to show the error bar
    formatOnSave: true # Whether or not to format automatically

  # Start things up
  activate: ->
    Jsfmt.start()
