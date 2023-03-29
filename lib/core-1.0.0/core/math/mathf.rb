module Core
  class Mathf
    def self.lerp(a, b, t)
      t = [0, [t, 1].min].max
      (1 - t) * a + t * b
    end
  end
end
