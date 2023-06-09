module FifteenPuzzleDR
  module Scenes
    class FifteenPuzzle < Core::Scene
      SIZE         = 4
      RANDOM_COUNT = 100
      END_ENV   = 'sfpco_end'

      attr_accessor :matrix
      attr_reader :is_deactivated

      def initialize
        super
        @h_end = lambda { end_game() }
        @c_movement = Components::FifteenPuzzle::Movement.new
        @c_input = Components::FifteenPuzzle::Input.new
      end

      def ready
        self.connect END_ENV, @h_end

        @matrix = Fifteen.get_matrix(SIZE)
        @is_deactivated = false

        self.add @c_movement, 'component_movement'
        self.add @c_input, 'component_input'

        create_pieces()
      end

      def update args
        if all_deactivated?
          self.get_scene(true).end_game
        end 
      end

      def all_deactivated?
        is_deactivated = true

        pieces = self.find_children('piece_')
        pieces.each do |piece|
          unless piece.is_deactivated
            is_deactivated = false
            break
          end
        end

        return is_deactivated
      end

      def create_pieces
        @matrix.each.with_index do |row, y|
          row.each.with_index do |number, x|
            piece = Objects::Fifteen::Piece.new
            self.add piece, "piece_#{number}"
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
end