
class Crossroad
  attr_reader :x, :y, :width, :height

  def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
  end

  def within?(x, y, width, height)
    return (x >= @x || x + width >= @x) && x <= @x + @width && (y >= @y || y + height >= @y) && y <= @y + @height
  end

  def to_s
    return "Crossroad(x=#{@x},y=#{@y},width=#{@width},height=#{@height})"
  end

  def ==(crossroad)
    return to_s == crossroad.to_s
  end

  def clone(x = @x, y = @y, width = @width, height = @height)
    return Crossroad.new(x, y, width, height)
  end
end

