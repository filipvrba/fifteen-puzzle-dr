module Core
  class Clock
    def initialize
      @time = Time.now
      # @fps_time = 1_000
      @fix_dt = (1 / 60).round(6)
    end
  
    def delta_time(&callback)
      current_time = Time.now
      dt = (current_time - @time)
  
      if dt > @fix_dt
        dt_count = (dt / @fix_dt).round
        dt_count.times do
          callback.call(@fix_dt) if callback
        end
      else
        callback.call(@fix_dt) if callback
      end
  
      @time = current_time
  
      return dt
    end
  end
end