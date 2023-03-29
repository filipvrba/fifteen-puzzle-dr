module Objects
  module Fifteen
    class Piece < Core::Object2
      SIZE  = 128
      SPEED = 0.5

      UPDATE_ENV = 'ofpco_update'

      def initialize
        super
        @h_update = lambda { |x, y| update_position(x, y) }
      end

      def ready
        self.connect(UPDATE_ENV, @h_update)

        @number = self.id.sub('piece_', '').to_i
        self.transform.position = self.transform.position.multiply_scalar(SIZE)
        self.transform.scale = Core::Vector2.new(SIZE, SIZE)
      end

      def update_position x, y
        self.transform.position = Core::Vector2.new(
          Core::Mathf.lerp(self.transform.position.x, self.transform.scale.x * x, SPEED),
          Core::Mathf.lerp(self.transform.position.y, self.transform.scale.x * y, SPEED)
        )
      end

      def update args
        if self.get_scene.is_deactivated
          self.transform.scale = Core::Vector2.new(
            Core::Mathf.lerp(self.transform.scale.x, SIZE * 1.1, 0.01),
            Core::Mathf.lerp(self.transform.scale.y, SIZE * 1.1, 0.01)
          )
        end
      end

      def draw outputs
        outputs.sprites << {
          x: self.global_position.x,
          y: self.global_position.y,
          w: self.global_scale.x,
          h: self.global_scale.y,
          path: "sprites/fifteen/pieces/#{self.id}.png"
        }
      end
    end
  end
end