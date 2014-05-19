Run = require('child_process').spawn;
ErrorView = require('./errorView');


module.exports = {
  start: function() {

    atom.workspaceView.eachEditorView(function(editorView) {
      // Now we have both the view and its editor.
      var editor = editorView.getEditor();

      // Create a new errorview for each editor.
      errorView = new ErrorView();
      errorView.hide();
      editorView.getPane().append(errorView);

      // Run any time any TextBuffer fires a 'saved' event
      editor.getBuffer().on("saved", function() {

        if (editor.getGrammar().scopeName === "source.js") {
          // Hide the error bar, if it's showing.
          errorView.hide();

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

              errorView.setMessage(msg);
              errorView.show();

              // Do things with the error
              console.log(msg, "Line: " + line, "col: " + col);
              // editor.setCursorBufferPosition([parseInt(line) - 1, parseInt(col)], {
              //   autoscroll: true
              // });
            }
          });
        }
      });

    });
  }
};
