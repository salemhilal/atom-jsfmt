#
# JsfmtRunner - Runs jsfmt on your code.
# This replaces jsfmt.coffee and doesn't rely on spawning a child process
#

jsfmt = require 'jsfmt'
fs = require 'fs'
path = require 'path'
{CompositeDisposable} = require 'atom'
{MessagePanelView, LineMessageView, PlainMessageView} = require 'atom-message-panel'


module.exports =
class JsfmtRunner

  @messagePanel
  @disposables = new CompositeDisposable

  # Initialize the class
  @start: =>
    # Commands
    atom.commands.add 'atom-workspace',
        'atom-jsfmt:format', => @formatCurrent()
    atom.commands.add 'atom-workspace',
        'atom-jsfmt:format-all-open-files', => @formatAllOpen()

    # Message panel that we'll share between editors
    @messagePanel = new MessagePanelView
        title: 'jsfmt'

    # Editor listeners
    @disposables.add atom.workspace.observeTextEditors (editor) =>
      @registerEditor editor

    # Close panel if we change editors
    @disposables.add atom.workspace.onDidChangeActivePaneItem =>
      @messagePanel.close()

  # Clean up this mess
  @stop: =>
    @messagePanel.close()
    @messagePanel.clear()
    @messagePanel = null
    @disposables.dispose()

  # Things to do with an editor once it initializes.
  @registerEditor: (editor) =>
    @disposables.add editor.getBuffer().onWillSave =>
      #TODO: This throws a weird error if I inline this. I don't get why.
      shouldFormat = atom.config.get 'atom-jsfmt.formatOnSave'
      if shouldFormat
        @format(editor)

  # Formats a given editor, assuming it's editing javascript.
  @format: (editor) =>
    @messagePanel.close()

    # Let's make sure we're editing javascript.
    return if not @editorIsJs editor

    buff = editor.getBuffer()
    oldJs = buff.getText()
    newJs = ''

    # Attempt to format, log errors
    try
      newJs = jsfmt.format oldJs
    catch error
      console.log 'Jsfmt:', error.message, error
      @messagePanel.clear()
      @messagePanel.attach()
      @messagePanel.add new LineMessageView
          message: error.message
          className: 'text-error'
          line: @errorToMessage(error.message)

      # errorView.setMessage(error.message)
      return

    # Apply diff only.
    buff.setTextViaDiff newJs

  # Given an @error, generate an appropriate messageView
  @errorToMessage: (error) =>
    line = @errorToLineNumber error
    console.log(line)
    if line is -1
      return new PlainMessageView
          message: error.message
          className: 'text-error'
    else return new LineMessageView
          message: error.message
          className: 'text-error'
          line: line

  @formatCurrent: () =>
    @format atom.workspace.getActiveTextEditor()

  @formatAllOpen: () =>
    editors = atom.workspace.getTextEditors()
    @format editor for editor in editors when @editorIsJs editor

  # Is the given editor editing javascript?
  @editorIsJs: (editor) ->
    return editor.getGrammar().scopeName is 'source.js'

  # Given an error message, returns its line number.
  @errorToLineNumber: (error) ->
    pattern = /^Line (\d+):.*/
    matched = error.message?.match(re)

    if not error.message? or matched.length is not 2
      return -1
    else
      return matched[1]
