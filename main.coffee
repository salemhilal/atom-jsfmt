JsfmtRunner = require './lib/jsfmtRunner'

module.exports =

  # Configuration
  config:
    showErrors:             # Whether or not to show the error bar
      title: 'Show errors'
      description: 'Do you want to see errors jsfmt finds?'
      type: 'boolean'
      default: 'true'
    formatOnSave:           # Whether or not to format automatically
      title: 'Format on save'
      description: 'Should files be formatted automatically on save?'
      type: 'boolean'
      default: 'true'
    saveAfterFormatting:    # Whether or not to save after formatting
      title: 'Save after formatting'
      description: 'Should formatting changes be saved immediately?'
      type: 'boolean'
      default: 'false'

  # Start things up
  activate: ->
    JsfmtRunner.start()

  deactivate: ->
    JsfmtRunner.stop()
