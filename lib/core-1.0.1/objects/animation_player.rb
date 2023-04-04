module Objects
  class AnimationPlayer < Core::BasicObject
    ANIM_FINISH = "oapcb_anim_finish"

    attr_reader :animations

    def animation
      return @animations[@current_animation]
    end

    def initialize
      super
  
      @animations = {}
      @playback_active = false
      @current_animation = nil
      @time = 0
      @play_callback = nil
    end

    def update args
      unless @playback_active
        return
      end
  
      @time += args.state.delta_time
  
      unless animation.is_done
        animation.tracks.each do |track|
          unless track.is_done
            track.keys.each do |key|
              unless key.is_done
                update_key(args.state.delta_time, track, key)
                break
              end
            end # keys
          end
        end # tracks
      else
        animation.reset()
        self.emit(ANIM_FINISH, @current_animation)
        @play_callback.call() if @play_callback
        stop()
      end
    end

    def update_key dt, track, key
      value = (key.value - track.key_last.value) / (key.time - track.key_last.time) * dt
      value = value.nan? ? 0 : value

      apply_str(track, "= #{track.track} + #{value}")
  
      if @time >= key.time
        key.is_done = true
        apply_str(track, "= #{key.value}")
        return
      end
    end

    def apply_str track, str_code = ""
      str = "self.#{track.track} #{str_code.to_s}"
      return eval(str)
    end
  
    def add_animation name, animation
      @animations[name] = animation
    end

    def play name, &callback
      stop()
      @current_animation = name
      @playback_active = true

      if callback
        @play_callback = callback
      end
    end
  
    def stop()
      @play_callback = nil
      @current_animation = nil
      @playback_active = false
      @time = 0
    end
  end
end