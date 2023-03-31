module Scenes
  class Root < Core::Scene
    def initialize
      super
      
      @fifteen = Scenes::FifteenPuzzle.new
      self.add @fifteen, 'fifteen_puzzle'
    end

    def end_game
      @fifteen.free
      self.add @fifteen, 'fifteen_puzzle'
    end

    def tick args
      self.emit(Core::Events::INPUT, args.inputs)
      self.emit(Core::Events::UPDATE, args)
      self.emit(Core::Events::DRAW, args.outputs)
    end
  end
end