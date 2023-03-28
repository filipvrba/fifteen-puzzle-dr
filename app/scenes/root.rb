module Scenes
  class Root < Core::Scene
    def initialize
      super
      
      
    end

    def tick args
      self.emit(Core::Events::INPUT, args.inputs)
      self.emit(Core::Events::UPDATE, args)
      self.emit(Core::Events::DRAW, args.outputs)
    end
  end
end