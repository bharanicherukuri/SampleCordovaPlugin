var exec = require('cordova/exec');

exports.sampleMethod = function(arg0, success, error) {
    exec(success, error, 'SampleCordovaPlugin', 'sampleMethod', [arg0]);
};

exports.sampleMethodjs = function(arg0, success, error) {
    if (arg0 && typeof(arg0) === 'string' && arg0.length > 0) {
      success(arg0);
    } else {
      error('Empty message!');
    }
};