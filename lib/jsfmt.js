var run = require('child_process').spawn,
  ErrorView = require('./errorView');
// StatusView = require('./statusView');
// TODO: Create a class that is paired with each editor, so that you
// can maintain state. Update global status with atom.workspace.getActiveEditor()
// There's gotta be an event for that, too.
// If you have state, you can bind events to config options, so that checking 'show errors'
// shows errors immediately, not after save

// Initialization
var start = function() {
  "use strict";

  // Register commands
  atom.workspaceView.command('atom-jsfmt:format', function() {
    formatCurrent();
  });

  // Register listeners
  atom.workspaceView.eachEditorView(register);
};

// Register editorView
var register = function(editorView) {

  var editor = editorView.getEditor();

  // Create a new errorview for each editor.
  var errorView = new ErrorView();
  errorView.hide();
  editorView.getPane().append(errorView);
  if (!editor.jsfmt) { // TODO: This feels gross.
    editor._jsfmt = {
      errorView: errorView
    };
  }

  // Run any time any TextBuffer fires a 'saved' event
  editor.getBuffer().on("saved", function() {
    // Hide the error bar, if it's showing.
    editor._jsfmt.errorView.hide();
    // TODO: Make a "format on save" option.
    // Format if javascript.
    if (atom.config.get('atom-jsfmt.formatOnSave') &&
      editor.getGrammar().scopeName === "source.js") {
      format(editor);
    }
  });
};

// Formats the given uri
var format = function(editor) {
  // TODO: do we even need the -f flag here still?
  var args = ["-fw", editor.getUri()];
  var jsfmt = run(atom.config.get('atom-jsfmt.pathToJsfmt'), args);

  // Reload the buffer on completion
  jsfmt.on("exit", function(code) {
    if (code !== 0) {
      console.error("Non-zero exit code: ", code);
    }
    editor.getBuffer().reload();
  });

  // Log any errors. Do cooler things with this later
  jsfmt.stderr.on("data", function(data) {
    // Get the error, line number and column number from the error
    var err = data.toString();
    var errInfo = /.*\[(.*).*\].*lineNumber: (\d+), column: (\d+).*/.exec(err);

    if (!errInfo || errInfo.length != 4) {
      // There's some sort of output I'm not parsing properly
      console.error(err);
    } else {
      // Everything looks fine, get parsed data
      var msg = errInfo[1],
        line = errInfo[2],
        col = errInfo[3];

      // Do things with the error
      if (atom.config.get('atom-jsfmt.showErrors')) {
        editor._jsfmt.errorView.setMessage(msg);
        editor._jsfmt.errorView.show();
      }
    }
  });
};

// Formats the currently active editor.
var formatCurrent = function() {
  // TODO: this currently acts on the file on disk, not on what's in the editor.
  // Either save first, or act on the editor's text.
  var editor = atom.workspace.getActiveEditor();
  format(editor);
};

// TODO: Formats all javascript in active directory
var formatProject = function() {
  // atom.project.path
  // Should change format to take uri and use callbacks for errors
};

module.exports = {
  start: start,
  format: format,
  formatCurrent: formatCurrent
};
