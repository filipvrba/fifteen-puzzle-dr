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

      def move l_function
        self.parent.matrix = l_function.call()
        self.parent.compare()
      end
    end
  end
end