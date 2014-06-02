class Shoes
  module Atom
    class App
      extend Forwardable

      def initialize(dsl_app)
        @dsl = dsl_app
        @js = Shoes::Browser::App.new(@dsl)

        init_subscriptions
      end

      def_delegators :@js, :app, :dsl, :real, :started?, :app_index

      def width
        publish 'get-window-size', app_index
        @js.width
      end

      def height
        publish 'get-window-size', app_index
        @js.height
      end

      def open
        publish 'shoes-app-ready', app_index, @dsl.width, @dsl.height
        @js.open
      end

      private
      def publish(message, *args)
        # Hack around unsupported splat expansion
        one, two, three, four, five, six = args[0], args[1], args[2], args[3], args[4], args[5]
        `#{@pubsub}.send(#{message}, #{one}, #{two}, #{three}, #{four}, #{five}, #{six});`
      end

      def init_subscriptions
        # @ipc.on 'window-size' do |size|
        #   @width, @height = size[0], size[1]
        # end
        @pubsub = `require('ipc');`
        %x|
          #{@pubsub}.on('window-size', function(size) {
            #{@js.width} = size[0];
            #{@js.height} = size[1];
          });
        |
      end
    end
  end
end
