var fs = require('fs');
var path = require('path');
var userFolder = process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'];

var exportsTextPath = path.join(__dirname, '..', 'configs', 'exports.txt');
var bashProfilePath = path.join(userFolder, '.bash_profile');


(function () {
    fs.readFile(exportsTextPath, function (err, data) {
        if(err){
            return console.log('Error loading exports.xml');
        }
        fs.appendFile(bashProfilePath, data, function () {
            console.log('Environment variables have been set.');
        });
    })
}());