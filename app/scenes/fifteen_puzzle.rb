module Scenes
  class FifteenPuzzle < Core::Scene
    SIZE         = 4
    RANDOM_COUNT = 1
    END_ENV   = 'sfpco_end'

    attr_accessor :matrix
    attr_reader :is_deactivated

    def initialize
      super
      @h_end = lambda { end_game() }
      @c_movement = Components::FifteenPuzzle::Movement.new
      @c_input = Components::FifteenPuzzle::Input.new

      @matrix = Fifteen.get_matrix(SIZE)
      @is_deactivated = false
    end

    def ready
      self.connect END_ENV, @h_end

      self.add @c_movement, 'component_movement'
      self.add @c_input, 'component_input'

      create_pieces()
    end

    def create_pieces
      @matrix.each.with_index do |row, y|
        row.each.with_index do |number, x|
          piece = Objects::Fifteen::Piece.new
          self.add piece, "piece_#{number}"
        end
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