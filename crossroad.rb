
class Crossroad
  attr_reader :x, :y, :width, :height

  def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
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
    dump = Marshal.dump self

    if car.horizontal?
      res = space.take [ :traffic, :crossroad, dump, nil, Marshal.dump(Direction.empty) ]

      direction = Marshal.load res[3]
      direction.remove car
    
      space.write [ :traffic, :crossroad, dump, Marshal.dump(direction), res[4] ]
    elsif car.vertical?
      res = space.take [ :traffic, :crossroad, dump, Marshal.dump(Direction.empty), nil ]

      direction = Marshal.load res[4]
      direction.remove car

      space.write [ :traffic, :crossroad, dump, res[3], Marshal.dump(direction) ]
    end

    nil
  end

  def take_by(car)
    dump = Marshal.dump self

    if car.horizontal?
      res = space.take [ :traffic, :crossroad, dump, nil, Marshal.dump(Direction.empty) ]

      direction = Marshal.load res[3]
      direction.add car

      space.write [ :traffic, :crossroad, dump, Marshal.dump(direction), res[4] ]
    elsif car.vertical?
      res = space.take [ :traffic, :crossroad, dump, Marshal.dump(Direction.empty), nil ]

      direction = Marshal.load res[4]
      direction.add car

      space.write [ :traffic, :crossroad, dump, res[3], Marshal.dump(direction) ]
    end

    Marshal.load res[2]
  end

  def create
    dump = Marshal.dump self

    space.write [ :map, :crossroad, dump ]
    space.write [ :traffic, :crossroad, dump, Marshal.dump(Direction.empty), Marshal.dump(Direction.empty) ]
  end

  def self.all
    @@crossroads ||= Rinda::RingFinger.primary.read_all([ :map, :crossroad, nil ]).collect{ |t| Marshal.load t[2] }
  end

  def self.find_by_coordinates(x, y, width, height)
    all.detect{ |crossroad| crossroad.on?(x, y, width, height) }
  end

  def space
    Rinda::RingFinger.primary
  end
end

