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
    atom.workspaceView.command 'atom-jsfmt:format', => @formatCurrent()
    atom.workspaceView.eachEditorView @registerEditor
    
    
  @registerEditor: (editorView) =>
    editor = editorView.getEditor()
    
    errorView = new ErrorView()
    editorView.append(errorView)
    
    editor._jsfmt = {errorView}
    
    editor.getBuffer().on 'saved' , =>
      editor._jsfmt.errorView.hide()
      shouldFormat = atom.config.get 'atom-jsfmt.formatOnSave' 
      
      if shouldFormat and editor.getGrammar().scopeName == 'source.js'
        @format(editor)
  
  
  @format: (editor) ->
    errorView = editor._jsfmt.errorView
    buff = editor.getBuffer()
    oldJs = buff.getText()
    newJs = ''
    
    # Attempt to format, log errors
    try
      newJs = jsfmt.format oldJs
    catch error
      console.log 'Jsfmt:', error.message, error
      errorView.setMessage(error.message)
      return
    
    # Apply diff only. 
    buff.setTextViaDiff newJs   
    buff.save() if atom.config.get 'atom-jsfmt.saveAfterFormatting'
    
  
  @formatCurrent: () ->
    editor = atom.workspace.getActiveEditor()
    @format editor if editor.getGrammar().scopeName == 'source.js'
    