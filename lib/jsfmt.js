Run = require('child_process').spawn;


module.exports = {
  start: function() {

    atom.workspace.eachEditor(function(editor) {

      editor.getBuffer().on("saved", function() {

        if (editor.getGrammar().scopeName === "source.js") {
          args = ["-fw", editor.getUri()];
          var jsfmt = Run("jsfmt", args);
          jsfmt.stderr.on("data", function(data) {
            var err = data.toString();
            console.error(err);
          });
        }
      });

    });
  }
};
