#
# JsfmtRunner - Runs jsfmt on your code.
# This replaces jsfmt.coffee and doesn't rely on spawning a child process
#

ErrorView = require './errorView'
jsfmt = require 'jsfmt'
fs = require 'fs'
path = require 'path'

module.exports =
class JsfmtRunner

  @start: =>
    # Commands
    atom.commands.add 'atom-workspace',
        'atom-jsfmt:format', => @formatCurrent()
    atom.commands.add 'atom-workspace',
        'atom-jsfmt:format-all-open-files', => @formatAllOpen()

    # Editor listeners
    for editor in atom.workspace.getTextEditors()
      @registerEditor(editor)
    # atom.workspaceView.eachEditorView @registerEditor


  @registerEditor: (editor) =>
    # editor = editorView.getEditor()
    editorView = atom.views.getView(editor)

    # Editor may be created before view
    if !editor._jsfmt?.errorView
      errorView = new ErrorView()
      # editorView.append(errorView)

      editor._jsfmt = {errorView}

    else
      editorView.append(editor._jsfmt.errorView)

    console.log('format')
    editor.getBuffer().onWillSave =>
      editor._jsfmt.errorView.hide()

      # This throws a weird error if I inline this. I don't get why
      shouldFormat = atom.config.get 'atom-jsfmt.formatOnSave'
      if shouldFormat and @editorIsJs editor
        @format(editor)

  @format: (editor) ->
    # May not be a view for the editor yet.
    if !editor._jsfmt
      errorView = new ErrorView()
      editor._jsfmt = {errorView}

    errorView = editor._jsfmt?.errorView
    buff = editor.getBuffer()
    oldJs = buff.getText()
    newJs = ''

    # Attempt to format, log errors
    try
      newJs = jsfmt.format oldJs
    catch error
      console.error 'Jsfmt:', error.message, error
      errorView.setMessage(error.message)
      return

    # Apply diff only.
    buff.setTextViaDiff newJs

  @formatCurrent: () =>
    editor = atom.workspace.getActiveTextEditor()
    return if not @editorIsJs editor

    formatOnSave = atom.config.get 'atom-jsfmt.formatOnSave'
    if formatOnSave
      editor.getBuffer().save()
    else
      @format editor

  @formatAllOpen: () =>
    editors = atom.workspace.getTextEditors()
    @format editor for editor in editors when @editorIsJs editor

  @editorIsJs: (editor) =>
    return editor.getGrammar().scopeName is 'source.js'

