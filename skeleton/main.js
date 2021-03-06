var app = require('app');  // Module to control application life.
var BrowserWindow = require('browser-window');  // Module to create native browser window.
var ipc = require('ipc');

// Report crashes to our server.
require('crash-reporter').start();

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the javascript object is GCed.
var windows = [];

// Quit when all windows are closed.
app.on('window-all-closed', function() {
  if (process.platform != 'darwin')
  app.quit();
});

// This method will be called when atom-shell has done everything
// initialization and ready for creating browser windows.
app.on('ready', function() {
  // Create the browser window.
  var mainWindow = new BrowserWindow({width: 800, height: 600, title: 'Shoes Atom', show: false});
  windows.push(mainWindow);

  // and load the index.html of the app.
  mainWindow.loadUrl('file://' + __dirname + '/index.html');

  // Emitted when the window is closed.
  mainWindow.on('closed', function() {
    var index = windows.indexOf(mainWindow);
    windows.splice(index, 1);
    mainWindow = null;
  });
});

ipc.on('shoes-app-ready', function(event, index, width, height) {
  // Atom's height includes the window chrome, but Shoes's doesn't
  var chromeHeight = 22;
  windows[index].setSize(width, height + chromeHeight);
  windows[index].show();
});

ipc.on('get-window-size', function(event, index) {
  var size = windows[index].getSize();
  ipc.send('window-size', size);
});

