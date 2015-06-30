var fs = require('fs');
var path = require('path');
var userFolder = process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'];

var settingsSecurityPath = path.join(__dirname, '..', 'configs', 'settings.xml');
var settingsSecurityTargetPath = path.join(userFolder, '.m2', 'settings.xml');

var config = require('./arguments/get');

console.log(config);
fs.readFile(settingsSecurityPath, 'utf-8', function (err, data) {
    var result;
    if(err){
        return console.log('Error loading settings.xml');
    }
    result = data
      .replace(/\{\{username\}\}/gim, config.user)
      .replace(/\{\{password\}\}/gim, config.password);

    fs.writeFile(settingsSecurityTargetPath, result, function () {
        console.log('Settings.xml has been set.');
    });
});