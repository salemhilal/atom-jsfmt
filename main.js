Jsfmt = require('./lib/jsfmt');

module.exports = {
  configDefaults: {
    pathToJsfmt: 'jsfmt', // Where the jsfmt binary is located
    showErrors: true, // Whether or not to show the error bar
  },
  activate: function() {
    Jsfmt.start();
  }
};
