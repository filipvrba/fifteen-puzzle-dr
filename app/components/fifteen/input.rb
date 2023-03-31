module Components
  module FifteenPuzzle
    class Input < Core::BasicObject
      CLICK_ENV = 'cfpicbo_click'
      
      def initialize
        super
        @h_click_piece = lambda do |x, y|
          if self.parent.is_deactivated
            return
          end

          position = Core::Vector2.new(x, y)
          emit_move( lambda { Fifteen.move_multiple_times(self.parent.matrix, position) } )
        end
      end

      def ready
        self.parent.connect CLICK_ENV, @h_click_piece
      end

      def free
        self.parent.disconnect CLICK_ENV, @h_click_piece
        super
      end

      def input inputs
        if self.parent.is_deactivated
          return
        end

        direction = Core::Vector2.new

        if inputs.keyboard.key_down.left ||
           inputs.keyboard.key_down.a
          direction.x = -1
        elsif inputs.keyboard.key_down.right ||
              inputs.keyboard.key_down.d
          direction.x = 1
        elsif inputs.keyboard.key_down.up ||
              inputs.keyboard.key_down.w
          direction.y = -1
        elsif inputs.keyboard.key_down.down ||
              inputs.keyboard.key_down.s
          direction.y = 1
        end

        unless direction.eql? Core::Vector2.new
          emit_move( lambda { Fifteen.move_last_number(self.parent.matrix, direction) } )
        end
      end

      def emit_move(l_function)
        self.parent.emit(
          Components::FifteenPuzzle::Movement::MOVE_ENV, l_function)
      end
    end
  end
end