class Shoes
  module Browser
    class TextBlock
      def initialize(dsl)
        @dsl = dsl
        @app = dsl.app.gui
      end

      attr_reader :dsl, :app

      def replace(*texts)
        text = texts.join(" ") + " "
        @real = %x|
          (function() {
            var span = document.createElement('span');
            span.classList.add(#{css_class_name});
            span.classList.add('shoes-element');
            span.innerHTML = #{text};
            #{@dsl.parent.gui.real}.appendChild(span);
            return span;
          })()
        |
      end

      def css_class_name
        "shoes-#{simple_class_name}"
      end

      def simple_class_name
        self.class.name.split('::').last.downcase
      end
    end

    class Banner < TextBlock; end
    class Title < TextBlock; end
    class Subtitle < TextBlock; end
    class Tagline < TextBlock; end
    class Caption < TextBlock; end
    class Para < TextBlock; end
    class Inscription < TextBlock; end
  end
end
