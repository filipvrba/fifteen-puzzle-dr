module Scenes
  class Root < Core::Scene
    def initialize
      super
      @clock = Core::Clock.new      
      @fifteen = Scenes::FifteenPuzzle.new
      self.add @fifteen, 'fifteen_puzzle'
    end

    def end_game
      @fifteen.free
      self.add @fifteen, 'fifteen_puzzle'
    end

    def tick args
      args.state.delta_time = @clock.delta_time do |f_dt|
        args.state.fix_delta_time = f_dt
        self.emit(Core::Events::PHYSICS_UPDATE, args)
      end

      self.emit(Core::Events::INPUT, args.inputs)
      self.emit(Core::Events::UPDATE, args)
      self.emit(Core::Events::DRAW, args.outputs)
    end
  end
end