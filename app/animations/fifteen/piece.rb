module Animations
  module Fifteen
    class Piece < Objects::AnimationPlayer
      SCALE_LITERAL = 'parent.parent.transform.scale'
      POSITION_LITERAL = 'parent.transform.position'

      def ready
        visible(0.3)
        invisible()
      end

      def visible time
        rand_time = rand * time
        animation = Structures::Animation.new

        # Position
        t_position_x = animation.add_track("#{POSITION_LITERAL}.x")
        t_position_x.add_insert_key(0, 0)
        t_position_x.add_insert_key(rand_time, Objects::Fifteen::Piece::SIZE / 2)
        t_position_x.add_insert_key(rand_time + time, 0)
        t_position_x.add_insert_key(rand_time + time * 1.5, 10)
        t_position_x.add_insert_key(rand_time + time * 2, 0)

        t_position_y = animation.add_track("#{POSITION_LITERAL}.y")
        t_position_y.add_insert_key(0, 0)
        t_position_y.add_insert_key(rand_time, Objects::Fifteen::Piece::SIZE / 2)
        t_position_y.add_insert_key(rand_time + time, 0)
        t_position_y.add_insert_key(rand_time + time * 1.5, 10)
        t_position_y.add_insert_key(rand_time + time * 2, 0)

        # Scale
        t_scale_x = animation.add_track("#{SCALE_LITERAL}.x")
        t_scale_x.add_insert_key(0, 0)
        t_scale_x.add_insert_key(rand_time, 0)
        t_scale_x.add_insert_key(rand_time + time, Objects::Fifteen::Piece::SIZE)
        t_scale_x.add_insert_key(rand_time + time * 1.5, Objects::Fifteen::Piece::SIZE - 20)
        t_scale_x.add_insert_key(rand_time + time * 2, Objects::Fifteen::Piece::SIZE)

        t_scale_y = animation.add_track("#{SCALE_LITERAL}.y")
        t_scale_y.add_insert_key(0, 0)
        t_scale_y.add_insert_key(rand_time, 0)
        t_scale_y.add_insert_key(rand_time + time, Objects::Fifteen::Piece::SIZE)
        t_scale_y.add_insert_key(rand_time + time * 1.5, Objects::Fifteen::Piece::SIZE - 20)
        t_scale_y.add_insert_key(rand_time + time * 2, Objects::Fifteen::Piece::SIZE)

        self.add_animation(:visible, animation)
      end

      def invisible
        animation = self.animations[:visible].reverse
        self.add_animation(:invisible, animation)
      end
    end
  end
end