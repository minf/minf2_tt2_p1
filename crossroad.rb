
class Crossroad
  attr_reader :x, :y, :width, :height

  def initialize(x, y, width, height)
    @space = Rinda::RingFinger.primary

    @x = x
    @y = y
    @width = width
    @height = height
  end

  def on?(x, y, width, height)
    return (x >= @x || x + width >= @x) && x <= @x + @width && (y >= @y || y + height >= @y) && y <= @y + @height
  end

  def ==(crossroad)
    return @x == crossroad.x && @y == crossroad.y && @width == crossroad.width && @height == crossroad.height
  end

  def clone(x = @x, y = @y, width = @width, height = @height)
    return Crossroad.new(x, y, width, height)
  end

  def release
    @space.write [ :traffic, :crossroad, Marshal.dump(self) ]

    nil
  end

  def take
    Marshal.load @space.take([ :traffic, :crossroad, Marshal.dump(self) ])[2]
  end

  def create
    @space.write [ :map, :crossroad, Marshal.dump(self) ]
    @space.write [ :traffic, :crossroad, Marshal.dump(self) ]
  end

  def self.all
    Rinda::RingFinger.primary.read_all([ :map, :crossroad, nil ]).collect{ |t| Marshal.load t[2] }
  end

  def self.find_by_coordinates(x, y, width, height)
    @@crossroads ||= all

    @@crossroads.detect{ |crossroad| crossroad.on?(x, y, width, height) }
  end
end

