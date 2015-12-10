JsfmtRunner = require './lib/jsfmtRunner'

module.exports =

  # Configuration
  config:
    showErrors:             # Whether or not to show the error bar
      title: 'Show errors'
      description: 'Do you want to know when something goes wrong?'
      type: 'boolean'
      default: 'true'
    formatOnSave:           # Whether or not to format automatically
      title: 'Format on save'
      description: 'Should files be formatted automatically on save?'
      type: 'boolean'
      default: 'true'
    applyToJSXFiles:
      title: 'Apply to JSX files (.jsx)'
      description: 'Formats files with the .jsx extension. You should have a jsfmt rule to ignore the actual JSX'
      type: 'boolean'
      default: 'false'

  # Start things up
  activate: ->
    JsfmtRunner.start()

  # Turn things off
  deactivate: ->
    JsfmtRunner.stop()
