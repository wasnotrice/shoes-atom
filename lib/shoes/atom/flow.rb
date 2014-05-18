class Shoes
  module Atom
    class Flow
      def initialize(dsl, parent)
        @dsl = dsl
        @parent = parent
        @app = parent.app

        @real = %x|
          (function() {
            var flow = document.createElement('div');
            flow.classList.add('shoes-flow');
            #{@parent.gui}.appendChild(flow);
            return flow;
          })()
        |
      end

      attr_reader :dsl, :parent, :app, :real
    end
  end
end
