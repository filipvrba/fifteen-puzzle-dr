module Core
  class BasicObject < Events
    attr_accessor :id, :parent
    attr_reader :children

    attr_accessor :update_handler, :draw_handler, :input_handler

    def initialize
      super
      
      @id = nil
      @parent = nil
      @children = []
    end

    def add object, id = nil
      if object == self
        puts "#{self.class.name}.add: object can't be added as a child of itself."
        return self
      end

      if object
        if object.parent
          object.parent.remove(object)
        end
        object.parent = self

        if id
          object.id = id
        end

        @children << object

        add_signals(object)
      else
        puts "#{self.class.name}.add: object not an instance of #{self.class.name}"
      end

      return self
    end

    def add_signals object
      # Added
      if object.respond_to?(Events::READY.to_sym)
        object.ready()
      end

      # Update
      if object.respond_to?(Events::UPDATE.to_sym)
        object.update_handler = lambda { |args| object.update(args) }
        get_scene(true).connect(Events::UPDATE, object.update_handler)
      end

      # Draw
      if object.respond_to?(Events::DRAW.to_sym)
        object.draw_handler = lambda { |args| object.draw(args) }
        get_scene(true).connect(Events::DRAW, object.draw_handler)
      end

      # Input
      if object.respond_to?(Events::INPUT.to_sym)
        object.input_handler = lambda { |args| object.input(args) }
        get_scene(true).connect(Events::INPUT, object.input_handler)
      end
    end

    def remove object
      index = @children.index(object)
      if index
        object.id = nil
        object.parent = nil
        @children.splice(index, 1)
      end

      return self
    end

    def free
      if @children.length > 0
        children = @children.clone
        children.each do |child|
          child.free
        end
      else
        if @parent
          free_signals()
          @parent.remove(self)
        end
      end

      if @parent
        @parent.free()
      end
    end

    def free_signals
      if self.respond_to?(Events::UPDATE.to_sym)
        get_scene(true).disconnect(Events::UPDATE, self.update_handler)
      end

      if self.respond_to?(Events::DRAW.to_sym)
        get_scene(true).disconnect(Events::DRAW, self.draw_handler)
      end

      if self.respond_to?(Events::INPUT.to_sym)
        get_scene(true).disconnect(Events::INPUT, self.input_handler)
      end
    end

    def get_scene(is_root = false, &block)
      _scene  = self
      _parent = _scene.parent

      while true
        if block
          block.call(_scene)
        end

        if is_root
          if _parent == nil
            break
          end
        else
          super_class_name = _parent.superclass.name
          is_scene_name = _parent.class.name == Scene::NAME_SCENE ||
                          super_class_name == Scene::NAME_SCENE

          if is_scene_name
            _scene = _parent
            break  
          end
        end

        _scene  = _parent
        _parent = _scene.parent
      end

      return _scene 
    end

    def find_child(id)
      result = nil
      @children.each do |child|
        if child.id == id
          result = child
          break
        end
      end

      return result
    end
  end
end