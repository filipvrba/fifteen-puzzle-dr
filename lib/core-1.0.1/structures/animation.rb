module Structures
  class Animation
    attr_reader :tracks

    def initialize
      @tracks = []
    end

    def add_track object_attr
      track = Structures::Track.new object_attr
      @tracks << track
      return track
    end

    def is_done
      result = true
      @tracks.each do |track|
        unless track.is_done
          result = false
          break
        end
      end
      return result
    end

    def reset()
      @tracks.each do |track|
        track.keys.each do |key|
          key.is_done = false
        end
      end
    end

    def reverse
      animation = Animation.new

      @tracks.each do |t|
        track = animation.add_track(t.track)
        r_keys = t.keys.reverse
        
        t.keys.each.with_index do |key, ik|
          track.add_insert_key(key.time, r_keys[ik].value)
        end
      end

      return animation
    end

    def to_s
      result = {tracks: []}
      @tracks.each { |t| result[:tracks] << t.to_s }
      result.to_s
    end
  end
end