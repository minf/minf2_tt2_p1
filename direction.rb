
class Direction
  def initialize
    @num = 0
  end

  def add(obj)
    @num += 1
  end

  def remove(obj)
    @num -= 1
  end

  def blank?
    return @num.zero?
  end

  def self.empty
    return Direction.new
  end
end

