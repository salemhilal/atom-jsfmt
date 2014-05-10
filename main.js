Jsfmt = require('./lib/jsfmt');

module.exports = {
  configDefaults: {
    pathToJsfmt: 'jsfmt' // Where the jsfmt binary is located
  },
  activate: function() {
    Jsfmt.start();
  }
};
