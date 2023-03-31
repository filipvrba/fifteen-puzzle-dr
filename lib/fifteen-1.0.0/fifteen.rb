require 'lib/fifteen-1.0.0/fifteen/version.rb'

module Fifteen
  def self.get_matrix(size)
    (1..(size * size)).to_a.each_slice(size).to_a
  end

  def self.eql? matrix
    matrix.eql? get_matrix(matrix.length)
  end

  def self.get_random_direction()
    l_rand = lambda do
      number = rand(2)
      if number == 0
        number = -1
      end
      return number
    end

    rand_xy = rand(2)
    direction = Core::Vector2.new
    if rand_xy == 0
      direction.x = l_rand.call()
    else
      direction.y = l_rand.call()
    end

    return direction
  end

  def self.get_last_number(matrix)
    matrix.length * matrix.length
  end

  def self.get_last_position(matrix)
    last_number = get_last_number(matrix)
    matrix.each.with_index do |e, y|
      x = e.index(last_number)
      if x
        return Core::Vector2.new(x, y)
      end
    end

    return nil
  end

  def self.move_last_number(matrix, direction, &block)
    last_pos = get_last_position(matrix)
    unless last_pos
      raise "The position for the last number was not found."
    end
    l_is_possible = lambda do |pos_xy, dir_xy|
      pos_xy - dir_xy >= 0 && pos_xy - dir_xy < matrix.length
    end

    is_possible = l_is_possible.call(last_pos.x, direction.x) &&
                  l_is_possible.call(last_pos.y, direction.y)
    if block
      block.call(is_possible)
    end

    if is_possible
      matrix[last_pos.y][last_pos.x] =
        matrix[last_pos.y - direction.y][last_pos.x - direction.x]
      matrix[last_pos.y - direction.y][last_pos.x - direction.x] = get_last_number(matrix)
    end

    return matrix
  end

  def self.move_multiple_times(matrix, position, &block)
    last_pos = get_last_position(matrix)
    
    unless last_pos.x == position.x ||
           last_pos.y == position.y
      return matrix
    end

    r_direction = Core::Vector2.new(
      last_pos.x - position.x,
      last_pos.y - position.y
    )
    n_direction = r_direction.normalize
    count = [
      r_direction.x.abs,
      r_direction.y.abs
    ].max

    count.each do
      matrix = move_last_number(matrix, n_direction) do |is_possible|
        if block
          block.call(is_possible)
        end
      end
    end

    return matrix
  end

  def self.move_random(matrix, number, &block)
    number.times do
      direction = Fifteen.get_random_direction()
      matrix = Fifteen.move_last_number(matrix, direction) do |is_possible|
        if block
          block.call(is_possible)
        end
      end
    end

    return matrix
  end

  def self.print(matrix)
    matrix.each do |e|
      p e
    end
  end
end
