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
      default: 'false'
    saveAfterFormatting:    # Whether or not to save after formatting
      title: 'Save after formatting'
      description: 'Should formatting changes be saved immediately?'
      type: 'boolean'
      default: 'true'

  # Start things up
  activate: ->
    JsfmtRunner.start()
