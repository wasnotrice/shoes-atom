class Shoes
  module Browser
    class Slot
      def initialize(dsl, parent)
        @dsl = dsl
        @parent = parent
        @app = parent.app

        @real = %x|
          (function() {
            var slot = document.createElement('div');
            slot.classList.add(#{css_class_name});
            #{@parent.real}.appendChild(slot);
            return slot;
          })()
        |
      end

      def css_class_name
        "shoes-#{simple_class_name}"
      end

      def simple_class_name
        self.class.name.split('::').last.downcase
      end

      attr_reader :dsl, :parent, :app, :real
    end

    class Flow < Slot
    end

    class Stack < Slot
    end
  end
end
