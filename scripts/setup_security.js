var fs = require('fs');
var path = require('path');
var userFolder = process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'];

var settingsSecurityPath = path.join(__dirname, '..', 'configs', 'settings-security.xml');
var settingsSecurityTargetPath = path.join(userFolder, '.m2', 'settings-security.xml');

(function (config) {
    fs.readFile(settingsSecurityPath, 'utf-8', function (err, data) {
        var result;
        if(err){
            return console.log('Error loading settings-security.xml');
        }
        result = data
            .replace(/\{\{user\}\}/gim, config.user)
            .replace(/\{\{password\}\}/gim, config.password);

        fs.writeFile(settingsSecurityTargetPath, result, function () {
            console.log('Settings-security.xml has been set.');
        });
    })
}(require('./arguments/get')));