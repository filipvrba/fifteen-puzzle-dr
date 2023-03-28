module Scenes
  class FifteenPuzzle < Core::Object2
    SIZE      = 4
    MOVE_ENV  = 'sfpco_move'
    END_ENV   = 'sfpco_end'

    def initialize
      super
      @h_move = lambda { |d| move(d) }
      @h_end = lambda { end_game() }

      @matrix = Fifteen.get_matrix(SIZE)
      @is_end = false
    end

    def ready
      self.connect MOVE_ENV, @h_move
      self.connect END_ENV, @h_end

      @matrix.each.with_index do |row, y|
        row.each.with_index do |number, x|
          piece = Objects::Fifteen::Piece.new
          piece.transform.position = Core::Vector2.new(x, y)
          self.add piece, "piece_#{number}"
        end
      end
    end
    
    def input inputs
      if @is_end
        return
      end

      direction = Core::Vector2.new

      if inputs.keyboard.key_down.left
        direction.x = 1
      elsif inputs.keyboard.key_down.right
        direction.x = -1
      elsif inputs.keyboard.key_down.up
        direction.y = 1
      elsif inputs.keyboard.key_down.down
        direction.y = -1
      end

      unless direction.eql? Core::Vector2.new
        self.emit(MOVE_ENV, direction)
      end
    end

    def move direction
      @matrix = Fifteen.move_last_number(@matrix, direction)
      p "---Matrix---"
      Fifteen.print @matrix

      if Fifteen.eql? @matrix
        self.emit(END_ENV)
      end
    end

    def end_game
      @is_end = true
      puts "[#{self.id}] MESSAGE end game"
    end
  end
end