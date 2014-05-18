class Shoes
  module Atom
    class TextBlock
      def initialize(dsl)
        @dsl = dsl
        @app = dsl.app.gui
        @real = %x|
          (function() {
            var span = document.createElement('span');
            span.classList.add('shoes-banner');
            span.innerHTML = #{@dsl.text};
            #{@dsl.parent.gui.real}.appendChild(span);
            return span;
          })()
        |
      end

      attr_reader :dsl, :app
    end

    class Banner < TextBlock; end
  end
end
