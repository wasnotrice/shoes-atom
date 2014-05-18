class Shoes
  module Atom
    class Flow
      def initialize(dsl, parent)
        @dsl = dsl
        @parent = parent
        @app = parent.app

        %x|
          var flow = document.createElement('div');
          flow.classList.add('shoes-flow');
          #{@parent.gui}.appendChild(flow);
        |
      end

      attr_reader :dsl, :parent, :app
    end
  end
end
