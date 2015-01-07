class Shoes
  module Browser
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
      end

      attr_reader :app, :dsl, :real

      def started?
        @started
      end

      def width
        @width
      end

      def height
        @height
      end

      def gutter
        16
      end

      def open
        @started = true
      end

      private
      def app_index
        Shoes.apps.index(@dsl.app)
      end
    end
  end
end
