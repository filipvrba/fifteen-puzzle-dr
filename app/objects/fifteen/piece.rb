module Objects
  module Fifteen
    class Piece < Core::Object2
      SIZE  = 128
      SPEED = 0.5
      
      UPDATE_ENV = 'ofpco_update'

      attr_accessor :is_deactivated

      def initialize
        super
        @h_update = lambda { |x, y| update_position(x, y) }

        @draw = Components::Piece::Draw.new
        @is_deactivated = false
      end

      def ready
        self.connect(UPDATE_ENV, @h_update)
        self.add @draw, 'draw'

        @number = self.id.sub('piece_', '').to_i
        self.transform.position = self.transform.position.multiply_scalar(SIZE)
      end

      def update_position x, y
        self.transform.position = Core::Vector2.new(
          Core::Mathf.lerp(self.transform.position.x, (SIZE) * x, SPEED),
          Core::Mathf.lerp(self.transform.position.y, (SIZE) * y, SPEED)
        )
      end

      def input inputs
        if inputs.mouse.click &&
            inputs.mouse.inside_rect?({
              x: self.global_position.x,
              y: self.global_position.y,
              w: self.global_scale.w,
              h: self.global_scale.h
            })
          
          self.get_scene.emit(Components::FifteenPuzzle::Input::CLICK_ENV,
            (self.transform.position.x / SIZE).abs.round,
            (self.transform.position.y / SIZE).abs.round
          )
        end
      end
    end
  end
end