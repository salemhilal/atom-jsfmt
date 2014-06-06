JsfmtRunner = require './lib/jsfmtRunner'

module.exports =

  # Configuration
  configDefaults:
    pathToJsfmt: '/usr/local/bin/jsfmt' # Where the jsfmt binary is located
    showErrors: true # Whether or not to show the error bar
    formatOnSave: true # Whether or not to format automatically

  # Start things up
  activate: ->
    process.env.PATH+=":/usr/local/bin"
    JsfmtRunner.start()
