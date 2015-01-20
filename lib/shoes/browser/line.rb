class Shoes
  module Browser
    class Line
      def initialize(dsl, app)
        @dsl = dsl
        @app = app

        %x{
          (function() {
            var canvas = #{@app.canvas};
            var context = canvas.getContext('2d');
            if (context) {
              context.beginPath();
              context.moveTo(#{@dsl.point_a.x}, #{@dsl.point_a.y});
              context.lineTo(#{@dsl.point_b.x}, #{@dsl.point_b.y});
              context.stroke();
            }
          })()
        }
      end
    end
  end
end
