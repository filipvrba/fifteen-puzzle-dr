module Structures
  class Key
    attr_accessor :is_done
    attr_reader :time, :value

    def initialize time, value
      @time    = time
      @value   = value
      @is_done = false
    end

    def to_s
      {
        time: @time,
        value: @value,
        is_done: @is_done
      }.to_s
    end
  end
end