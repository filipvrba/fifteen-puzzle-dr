module Core
  class Events
    ADDED          = "added"
    READY          = "ready"
    UPDATE         = "update"
    DRAW           = "draw"
    INPUT          = "input"

    attr_accessor :signals

    def initialize
      @signals = nil
    end

    def connect type_s, handler
      if @signals == nil
        @signals = { }
      end

      if @signals[type_s] == nil
        @signals[type_s] = []
      end

      if @signals[type_s].index(handler) == nil
        @signals[type_s] << handler
      end
    end

    def disconnect type_s, handler
      if @signals == nil
        return
      end

      handlers = @signals[type_s]

      unless handlers == nil
        index = handlers.index(handler)
      end
      unless index == -1
        handlers.splice(index, 1)
      end
    end

    def exist? type_s, handler
      if @signals == nil
        return false
      end

      return @signals[type_s] != nil &&
        @signals[type_s].index(handler) != nil
    end

    def emit type_s, *args
      if @signals == nil
        return false
      end

      handlers = @signals[type_s]
      if handlers
        if type_s == ADDED and self.respond_to?(READY.to_sym)
          return
        end

        handlers.each do |handler|
          handler.call(*args)
        end
      end
    end
  end
end