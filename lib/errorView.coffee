{View} = require 'atom'

module.exports =

class JsfmtErrorView extends View
	# Essentially contains just one tool panel, with one message
  @content: ->
    @div class: 'tool-panel panel-bottom padded', =>
      @span class: 'text-error', '⚠ '
      @span outlet: 'message', 'Error here'

	# Sets the error message
  setMessage: (msg) ->
    @message.text(msg)
