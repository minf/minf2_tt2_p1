
class Car < GameObject
  def initialize(position, velocity, image)
    @velocity = velocity

    surface = Rubygame::Surface.load image

    @width = surface.width
    @height = surface.height

    super(position, surface)

    Thread.new do
      loop do
        trace { drive }

        sleep 0.01
      end
    end
  end

  def drive
    new_x = (@x + @velocity[0]) % Game.instance.map.width
    new_y = (@y + @velocity[1]) % Game.instance.map.height

    take_crossroad(new_x, new_y)

    @x = new_x
    @y = new_y
  end

  def take_crossroad(x, y)
    @crossroad = @crossroad.release if @crossroad && !@crossroad.on?(x, y, @width, @height)

    crossroad = Crossroad.find_by_coordinates(x, y, @width, @height)

    @crossroad = crossroad.take if crossroad && @crossroad != crossroad
  end
end

