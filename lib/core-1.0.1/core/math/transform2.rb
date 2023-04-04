module Core
  class Transform2
    attr_accessor :position, :rotation, :scale
    
    def initialize(position = Vector2.new,
        rotation = 0, scale = Vector2.new(1, 1))
        
      @position = position
      @rotation = rotation
      @scale    = scale
    end
  end
end