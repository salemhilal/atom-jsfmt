{View} = require 'atom'

module.exports =

class JsfmtErrorView extends View

  initialize: ->
    @hide()

  # Essentially contains just one tool panel, with one message
  @content: ->
    @div class: 'jsfmt hellotheresmallchildren', =>
      @div class: 'tool-panel panel-bottom padded', =>
        @span class: 'text-error', '⚠ '
        @span outlet: 'message', ''

  # Sets the error message
  setMessage: (msg) ->
    @message.text(msg)
