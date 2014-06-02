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

        init_subscriptions
      end

      attr_reader :app, :dsl, :height, :real, :width

      def started?
        @started
      end

      def width
        publish 'get-window-size', app_index
        @width
      end

      def height
        publish 'get-window-size', app_index
        @height
      end

      def open
        publish 'shoes-app-ready', app_index, @dsl.width, @dsl.height
        @started = true
      end

      def publish(message, *args)
        # Hack around unsupported splat expansion
        one, two, three, four, five, six = args[0], args[1], args[2], args[3], args[4], args[5]
        `#{@ipc}.send(#{message}, #{one}, #{two}, #{three}, #{four}, #{five}, #{six});`
      end

      private
      def app_index
        Shoes.apps.index(@dsl.app)
      end

      def init_subscriptions
        # @ipc.on 'window-size' do |size|
        #   @width, @height = size[0], size[1]
        # end
        %x|
          #{@ipc}.on('window-size', function(size) {
            #{@width} = size[0];
            #{@height} = size[1];
          });
        |
      end
    end
  end
end

