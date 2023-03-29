module Objects
  class Camera < Core::Object2
    attr_accessor :scene
    
    def initialize scene
      @scene = scene
    end

    def draw outputs
      outputs.sprites << {
        x: self.global_position.x,
        y: self.global_position.y,
        w: self.global_scale.w,
        h: self.global_scale.h,
        path: @scene.id.to_sym
      }
    end
  end
end