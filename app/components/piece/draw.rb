module Components
  module Piece
    class Draw < Core::Object2
      def initialize
        super
        @h_end = lambda { end_game() }
      end

      def ready
        self.get_scene.connect Scenes::FifteenPuzzle::END_ENV, @h_end

        @animations = Animations::Fifteen::Piece.new
        self.add @animations, 'animations'
        @animations.play(:visible)
      end

      def draw outputs
        outputs.sprites << {
          x: self.global_position.x,
          y: self.global_position.y,
          w: self.global_scale.x,
          h: self.global_scale.y,
          path: "sprites/fifteen/pieces/#{self.parent.id}.png",
        }
      end

      def end_game
        @animations.play(:invisible) do
          self.parent.is_deactivated = true
        end
      end
    end
  end
end