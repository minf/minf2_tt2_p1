
class Crossroad < GameObject
  attr_reader :x, :y, :width, :height

  def initialize(x, y, width, height)
    @space = Rinda::RingFinger.primary

    @x = x
    @y = y
    @width = width
    @height = height

    super [x, y]
  end

  def draw(screen)
    Rubygame::Surface.load("images/crossroad.png").blit screen, [ @x, @y ]
  end

  def on?(x, y, width, height)
    (x >= @x || x + width >= @x) && x <= @x + @width && (y >= @y || y + height >= @y) && y <= @y + @height
  end

  def ==(crossroad)
    @x == crossroad.x && @y == crossroad.y && @width == crossroad.width && @height == crossroad.height
  end

  def clone(x = @x, y = @y, width = @width, height = @height)
    Crossroad.new(x, y, width, height)
  end

  def release_by(car)
    @space.take [ :traffic, :crossroad, Marshal.dump(self), Marshal.dump(car.object_id) ]
    @space.write [ :traffic, :crossroad, Marshal.dump(self), Marshal.dump(EmptyCar.new) ]

    nil
  end

  def take_by(car)
    res = Marshal.load @space.take([ :traffic, :crossroad, Marshal.dump(self), Marshal.dump(EmptyCar.new) ])[2]

    @space.write [ :traffic, :crossroad, Marshal.dump(self), Marshal.dump(car.object_id) ]

    res
  end

  def create
    @space.write [ :map, :crossroad, Marshal.dump(self) ]
    @space.write [ :traffic, :crossroad, Marshal.dump(self), Marshal.dump(EmptyCar.new) ]
  end

  def self.all
    Rinda::RingFinger.primary.read_all([ :map, :crossroad, nil ]).collect{ |t| Marshal.load t[2] }
  end

  def self.find_by_coordinates(x, y, width, height)
    @@crossroads ||= all

    @@crossroads.detect{ |crossroad| crossroad.on?(x, y, width, height) }
  end
end

