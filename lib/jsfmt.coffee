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

    jsfmtProc = spawn jsfmtBin, args

    # Reload the buffer when the process exits
    jsfmtProc.on 'exit', (code) ->
      console.error 'Non-zero exit code', code if code != 0
      editor.getBuffer().reload()

    jsfmtProc.on 'error', (err) ->
      if atom.config.get 'atom-jsfmt.showErrors'

        if /.*ENOENT.*/.test(err.toString())
          msg = 'I couldn\'t find jsfmt on your computer. ' +
                'Check your "pathToJsfmt" and try again.'
          editor._jsfmt.errorView.setMessage(msg)
          editor._jsfmt.errorView.show()
        else
          msg = 'An unhandled error occurred. Please check the console ' +
                'for more details.'
          editor._jsfmt.errorView.setMessage(msg)
          editor._jsfmt.errorView.show()
          console.log "jsfmt error: ", err.toString()

    # Log / show any errors
    jsfmtProc.stderr.on 'data', (data) ->
      errPattern = /.*\[(.*).*\].*lineNumber: (\d+), column: (\d+).*/
      errInfo = errPattern.exec data.toString()

      console.log "jsfmt error: ", data.toString()

      # This is caught by the on 'error' handler
      # TODO: Rethink this.
      return if /.*No such file or directory.*/.test data.toString()

      # Can we show errors?
      if atom.config.get 'atom-jsfmt.showErrors'
        if !errInfo or errInfo.length != 4
          msg = 'An unhandled error occurred. Please check the console ' +
                'for more details.'
          editor._jsfmt.errorView.setMessage(msg)
          editor._jsfmt.errorView.show()
        else
          [_, msg, line, col] = errInfo

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
