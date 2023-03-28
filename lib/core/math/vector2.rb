module Core
  class Vector2
    attr_accessor :x, :y
    
    def initialize(x = 0, y = 0)
      @x = x
      @y = y
    end
    
    def w
      @x
    end

    def h
      @y
    end

    def w=(x)
      @x = x
    end

    def h=(y)
      @y = y
    end

    def +(other)
      Vector2.new(@x + other.x, @y + other.y)
    end
    
    def -(other)
      Vector2.new(@x - other.x, @y - other.y)
    end
    
    def *(other)
      Vector2.new(@x * other.x, @y * other.x)
    end

    def multiply_scalar(scalar)
      Vector2.new(@x * scalar, @y * scalar)
    end
    
    def magnitude
      Math.sqrt(@x * @x + @y * @y)
    end
    
    def normalize
      mag = self.magnitude
      x = @x / mag
      y = @y / mag

      Vector2.new(x.nan? ? 0 : x, y.nan? ? 0 : y)
    end
    
    def to_s
      "(#{@x}, #{@y})"
    end
  end 
end
