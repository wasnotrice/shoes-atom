class Shoes
  module Atom
    class TextBlock
      def initialize(dsl)
        @dsl = dsl
        @app = dsl.app.gui
      end

      attr_reader :dsl, :app

      def replace(*texts)
        text = texts.join(" ")
        @real = %x|
          (function() {
            var span = document.createElement('span');
            span.classList.add('shoes-banner');
            span.innerHTML = #{text};
            #{@dsl.parent.gui.real}.appendChild(span);
            return span;
          })()
        |
      end
    end

    class Banner < TextBlock; end
  end
end
