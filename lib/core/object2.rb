module Core
  class Object2 < BasicObject
    attr_accessor :transform
    
    def initialize
      super
      @transform = Transform2.new
    end

    def global_position
      if self.parent
        position = Vector2.new
        self.get_scene(true) do |scene|
          position = position + scene.transform.position
        end

        return position
      else
        return @transform.position
      end
    end

    def global_rotation
      if self.parent
        rotation = 0
        self.get_scene(true) do |scene|
          rotation += scene.transform.rotation
        end

        return rotation
      else
        return @transform.rotation
      end
    end

    def global_scale
      if self.parent
        scale = Vector2.new(1, 1)
        length = 0
        self.get_scene(true) do |scene|
          length += 1
          scale = scale + scene.transform.scale
        end

        scale = Vector2.new(scale.w - length.to_f, scale.h - length.to_f)
        return scale
      else
        return @transform.scale
      end
    end
  end
end