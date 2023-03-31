module Scenes
  class FifteenPuzzle < Core::Scene
    SIZE         = 4
    RANDOM_COUNT = 100
    MOVE_ENV  = 'sfpco_move'
    END_ENV   = 'sfpco_end'

    attr_reader :is_deactivated

    def initialize
      super
      @h_move = lambda do |d|
        l_function = lambda { Fifteen.move_last_number(@matrix, d) }
        move(l_function)
      end
      @h_end = lambda { end_game() }
      @h_click_piece = lambda do |x, y|
        position = Core::Vector2.new(x, y)
        l_function = lambda { Fifteen.move_multiple_times(@matrix, position) }
        move(l_function)
      end

      @matrix = Fifteen.get_matrix(SIZE)
      @is_deactivated = false
    end

    def ready
      self.connect MOVE_ENV, @h_move
      self.connect END_ENV, @h_end
      self.connect Objects::Fifteen::Piece::CLICK_ENV, @h_click_piece

      @matrix.each.with_index do |row, y|
        row.each.with_index do |number, x|
          piece = Objects::Fifteen::Piece.new
          self.add piece, "piece_#{number}"
        end
      end
      
      Fifteen.move_random(@matrix, RANDOM_COUNT)
    end
    
    def input inputs
      if @is_deactivated
        return
      end

      direction = Core::Vector2.new

      if inputs.keyboard.key_down.left
        direction.x = -1
      elsif inputs.keyboard.key_down.right
        direction.x = 1
      elsif inputs.keyboard.key_down.up
        direction.y = -1
      elsif inputs.keyboard.key_down.down
        direction.y = 1
      end

      unless direction.eql? Core::Vector2.new
        self.emit(MOVE_ENV, direction)
      end
    end

    def update args
      pieces_size = self.find_child('piece_1').transform.scale.x * SIZE
      self.transform.position = Core::Vector2.new(
        (args.grid.w * 0.5) - (pieces_size * 0.5),
        (args.grid.h * 0.5) + ((pieces_size * 0.5) * 0.5)
      )

      update_pieces()
    end

    def update_pieces
      @matrix.each.with_index do |row, y|
        row.each.with_index do |number, x|
          piece = self.find_child("piece_#{number}")
          piece.emit(Objects::Fifteen::Piece::UPDATE_ENV, x, -y)
        end
      end
    end

    def move l_function
      @matrix = l_function.call()
      compare()
    end

    def compare
      p "---Fifteen---"
      Fifteen.print @matrix

      if Fifteen.eql? @matrix
        self.emit(END_ENV)
      end
    end

    def end_game
      @is_deactivated = true
      puts "[#{self.id}] MESSAGE end game"
    end
  end
end