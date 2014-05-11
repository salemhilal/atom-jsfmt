Run = require('child_process').spawn;


module.exports = {
  start: function() {

    atom.workspace.eachEditor(function(editor) {

      // Run any time any TextBuffer fires a 'saved' event
      editor.getBuffer().on("saved", function() {

        if (editor.getGrammar().scopeName === "source.js") {
          // Run jsfmt
          var args = ["-fw", editor.getUri()];
          var jsfmt = Run(atom.config.get('atom-jsfmt.pathToJsfmt'), args);

          // Log any errors. Do cooler things with this later
          jsfmt.stderr.on("data", function(data) {
            // Get the error, line number and column number from the error
            var err = data.toString();
            var errInfo = /.*\[(.*).*\].*lineNumber: (\d+), column: (\d+).*/.exec(err);
            var msg = errInfo[1],
              line = errInfo[2],
              col = errInfo[3];
            console.log(msg, "Line: " + line, "col: " + col);
            editor.setCursorBufferPosition([parseInt(line) - 1, parseInt(col)], {
              autoscroll: true
            });
          });
        }
      });

    });
  }
};
