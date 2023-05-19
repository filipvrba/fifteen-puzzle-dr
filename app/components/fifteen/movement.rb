module FifteenPuzzleDR
  module Components
    module FifteenPuzzle
      class Movement < Core::BasicObject
        MOVE_ENV  = 'cfpmcb_move'

        def initialize
          super

          @h_move = lambda { |l_fn| move(l_fn) }
        end

        def ready
          self.parent.connect MOVE_ENV, @h_move
        
          Fifteen.move_random(self.parent.matrix, Scenes::FifteenPuzzle::RANDOM_COUNT)
        end

        def free
          self.parent.disconnect MOVE_ENV, @h_move
          super
        end

        def move l_function
          self.parent.matrix = l_function.call()
          self.parent.compare()
        end

        def update args
          # pieces_size = self.parent.find_child('piece_1').transform.scale.x *
          pieces_size = Objects::Fifteen::Piece::SIZE * 
            Scenes::FifteenPuzzle::SIZE
          self.parent.transform.position = Core::Vector2.new(
            (args.grid.w * 0.5) - (pieces_size * 0.5),
            (args.grid.h * 0.5) + ((pieces_size * 0.5) * 0.5)
          )
    
          update_pieces()
        end
    
        def update_pieces
          self.parent.matrix.each.with_index do |row, y|
            row.each.with_index do |number, x|
              piece = self.parent.find_child("piece_#{number}")
              piece.emit(Objects::Fifteen::Piece::UPDATE_ENV, x, -y)
            end
          end
        end
      end
    end
  end
end