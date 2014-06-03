{spawn} = require 'child_process'
ErrorView = require './errorView'

module.exports =
class Jsfmt
  # Registers commands and editors
  @start: =>
    atom.workspaceView.command 'atom-jsfmt:format', => @formatCurrent()
    atom.workspaceView.eachEditorView @registerEditor

  # Gets given editorView ready for jsfmt
  @registerEditor: (editorView) =>
    editor = editorView.getEditor()

    errorView = new ErrorView()
    editorView.append(errorView)

    editor._jsfmt = {errorView}

    editor.getBuffer().on 'saved', =>
      editor._jsfmt.errorView.hide()
      shouldFormat = atom.config.get 'atom-jsfmt.formatOnSave'

      if shouldFormat and editor.getGrammar().scopeName == 'source.js'
        @format(editor)

  # Formats the given editor
  @format: (editor) ->
    args = ['-fw', editor.getUri()] # We may not need the -f flag anymore
    jsfmtBin = atom.config.get('atom-jsfmt.pathToJsfmt').trim()
    console.log 'proc: "' + jsfmtBin + '"'
    console.log 'file: "' + args[1] + '"'
    jsfmtProc = spawn jsfmtBin, args

    # Reload the buffer when the process exits
    jsfmtProc.on 'exit', (code) ->
      console.error 'Non-zero exit code', code if code != 0
      editor.getBuffer().reload()

    # Log / show any errors
    jsfmtProc.stderr.on 'data', (data) ->
      errPattern = /.*\[(.*).*\].*lineNumber: (\d+), column: (\d+).*/
      errInfo = errPattern.exec data.toString()

      return console.error data.toString() if !errInfo or errInfo.length != 4

      [_, msg, line, col] = errInfo

      if atom.config.get 'atom-jsfmt.showErrors'
        editor._jsfmt.errorView.setMessage(msg)
        editor._jsfmt.errorView.show()

  # Formats the currently active editor
  # TODO: This currently acts on the file on disk, not on what's in the editor.
  # Ether save first, or acton the editor's text.
  @formatCurrent: ->
    editor = atom.workspace.getActiveEditor()
    @format editor if editor.getGrammar().scopeName == 'source.js'

  # TODO: Formats all javascript in active directory
  # @formatProject ->
