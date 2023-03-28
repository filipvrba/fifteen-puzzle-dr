module Objects
  module Fifteen
    class Piece < Core::Object2
      def ready
        @number = self.id.sub('piece_', '').to_i
      end

      def draw outputs
        
      end
    end
  end
end