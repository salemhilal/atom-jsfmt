# This replaces jsfmt.coffee and doesn't rely on spawning a child process
ErrorView = require './errorView'
jsfmt = require 'jsfmt'
fs = require 'fs'
path = require 'path'

module.exports = 
class JsfmtRunner
  
  @start: =>
    atom.workspaceView.command 'atom-jsfmt:format', => @formatCurrent()
    atom.workspaceView.eachEditorView @registerEditor
    
    # pathToTest = path.resolve(__dirname, '../test/test.js')
    # js = fs.readFileSync pathToTest
    # console.log "HERE GOES"
    # try
    #   console.log 'format: ', jsfmt.format(js)
    #   
    # catch error
    #   console.log error, error.message
    
    
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
    buff = editor.getBuffer()
    oldJs = buff.getText()
    newJs = ''
    
    try
      newJs = jsfmt.format oldJs
    catch error
      console.log error.message, error
      #@handleError error
      return
    
    # Apply diff only. 
    buff.setTextViaDiff newJs    
    
  
  @formatCurrent: () ->
    
  @handleError: () ->
    