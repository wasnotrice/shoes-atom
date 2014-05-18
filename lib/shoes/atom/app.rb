class Shoes
  module Atom
    class App
      def initialize(dsl)
        @dsl = dsl
        @gui = %x|
          (function() {
            var gui = document.createElement('div');
            gui.classList.add('shoes-app');
            document.body.appendChild(gui);
            return gui;
          })()
        |
        @started = false
        @on_ready = %x|
          function () {
            var app = this,
              mainWindow = new BrowserWindow({width: 600, height: 500});

            #{@browserWindow} = mainWindow;

            app.windows.push(mainWindow);
            mainWindow.loadUrl('file://' + __dirname + '/index.html');

            mainWindow.on('closed', function() {
              var windowIndex = app.windows.indexOf(mainWindow);
              app.windows.splice(windowIndex, 1);
              mainWindow = null;
            });
          }
        |
        %x|
          var ipc = require('ipc');
          ipc.send('shoes-app-created', #{@on_ready});
          ipc.on('shoes-app-loaded', function() {
            #{@started = true}
          });
        |
      end

      attr_reader :app, :gui

      def started?
        @started
      end

      def open
      end

      def width
        @browserWindow.getSize()[0]
      end

      def height
        @browserWindow.getSize()[1]
      end

    end
  end
end

