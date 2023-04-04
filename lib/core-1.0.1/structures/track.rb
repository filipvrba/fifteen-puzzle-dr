module Structures
  class Track
    attr_accessor :track
    attr_reader :keys

    def initialize track = nil
      @track = track
      @keys = []
    end

    def add_insert_key time, key
      unless @track
        puts "There is no declared 'track' value."
      end 

      @keys << Structures::Key.new(time, key)
    end

    def is_done
      result = true
      keys.each do |key|
        unless key.is_done
          result = false
          break
        end
      end
      return result
    end

    def key_last
      result = @keys[0]
      keys.each do |key|
        if key.is_done
          result = key
        end
      end

      return result
    end

    def to_s
      result = { track: @track, keys: [] }
      @keys.each { |k| result[:keys] << k.to_s }
      result.to_s
    end
  end
end