#
# JsfmtRunner - Runs jsfmt on your code.
# This replaces jsfmt.coffee and doesn't rely on spawning a child process
#

jsfmt = require 'jsfmt'
fs = require 'fs'
path = require 'path'
findNearestFile = require 'nearest-file'
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

    @scopes = ['source.js']
    @scopes.push 'source.js.jsx' if atom.config.get 'atom-jsfmt.applyToJSXFiles'

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
    file = findNearestFile(editor.getPath(), '.jsfmtrc');
    oldJs = buff.getText()
    newJs = ''
    options = {}

    if file?
        try
            options = JSON.parse(file)
        catch error
            @errorToMessage(error)

    # Attempt to format, log errors
    try
      newJs = jsfmt.format(oldJs, options)
    catch error
      shouldError = atom.config.get 'atom-jsfmt.showErrors'
      if shouldError is true
        @messagePanel.clear()
        @messagePanel.attach()
        @messagePanel.add @errorToMessage(error)

      # errorView.setMessage(error.message)
      return

    # Apply diff only.
    buff.setTextViaDiff newJs

  # Given an @error, generate an appropriate messageView
  @errorToMessage: (error) =>
    line = @errorToLineNumber error
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
    return @scopes.indexOf(editor.getGrammar().scopeName) > -1

  # Given an error message, returns its line number.
  @errorToLineNumber: (error) ->
    return -1 if not error.message?

    pattern = /^Line (\d+):.*/
    matched = error.message.match(pattern)

    if not matched or matched.length is not 2
      return -1
    else
      return matched[1]
