Run = require('child_process').spawn;
ErrorView = require('./errorView');
// StatusView = require('./statusView');


module.exports = {
  start: function() {


    // TODO: Create a class that is paired with each editor, so that you
    // can maintain state. Update global status with atom.workspace.getActiveEditor()
    // There's gotta be an event for that, too.
    // If you have state, you can bind events to config options, so that checking 'show errors'
    // shows errors immediately, not after save
    atom.workspaceView.eachEditorView(function(editorView) {
      // Now we have both the view and its editor.
      var editor = editorView.getEditor();

      // Create a new errorview for each editor.
      var errorView = new ErrorView();
      errorView.hide();
      editorView.getPane().append(errorView);

      // Run any time any TextBuffer fires a 'saved' event
      editor.getBuffer().on("saved", function() {
        // Hide the error bar, if it's showing.
        errorView.hide();

        if (editor.getGrammar().scopeName === "source.js") {

          // Run jsfmt
          var args = ["-fw", editor.getUri()];
          var jsfmt = Run(atom.config.get('atom-jsfmt.pathToJsfmt'), args);

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
              console.log(msg, "Line: " + line, "col: " + col);
              if (atom.config.get('atom-jsfmt.showErrors')) {
                errorView.setMessage(msg);
                errorView.show();
              }

            }
          });
        }
      });

    });
  }
};
