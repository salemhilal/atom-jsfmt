Run = require('child_process').spawn;


module.exports = {
  start: function() {

    atom.workspace.eachEditor(function(editor) {

      // Run any time any TextBuffer fires a 'saved' event
      editor.getBuffer().on("saved", function() {

        if (editor.getGrammar().scopeName === "source.js") {
          // Run jsfmt
          args = ["-fw", editor.getUri()];
          var jsfmt = Run(atom.config.get('atom-jsfmt.pathToJsfmt'), args);

          // Log any errors. Do cooler things with this later
          jsfmt.stderr.on("data", function(data) {
            var err = data.toString();
            console.log(data.toString());
          });
        }
      });

    });
  }
};
