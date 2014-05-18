class Shoes
  module Atom
    class App
      def initialize(dsl)
        @dsl = dsl
        @real = %x|
          (function() {
            var gui = document.createElement('div');
            gui.classList.add('shoes-app');
            document.body.appendChild(gui);
            return gui;
          })()
        |
        @started = false
        # Channel to renderer context
        @ipc = `require('ipc');`
      end

      attr_reader :app, :dsl, :real

      def started?
        @started
      end

      def open
        `#{@ipc}.send('shoes-app-ready', #{app_index}, #{@dsl.width}, #{@dsl.height});`
        @started = true
      end

      def width
        `#{@ipc}.send('get-window-width', #{app_index})`
      end

      def height
        `#{@ipc}.send('get-window-height', #{app_index})`
      end

      def app_index
        Shoes.apps.index(@dsl.app)
      end
    end
  end
end

