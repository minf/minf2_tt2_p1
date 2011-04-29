
class Car < GameObject
  def initialize(position, velocity, image)
    @velocity = velocity

    @image = image

    surface = Rubygame::Surface.load @image

    @width = surface.width
    @height = surface.height

    super position

    Thread.new do
      loop do
        trace { drive }

        sleep 0.01
      end
    end
  end

  def draw(screen)
    Rubygame::Surface.load(@image).blit screen, [ @x, @y ]
  end

  def drive
    new_x = (@x + @velocity[0]) % Game.instance.map.width
    new_y = (@y + @velocity[1]) % Game.instance.map.height

    take_crossroad(new_x, new_y)

    @x = new_x
    @y = new_y
  end

  def take_crossroad(x, y)
    old_crossroad = @crossroad if @crossroad && !@crossroad.on?(x, y, @width, @height)

    crossroad = Crossroad.find_by_coordinates(x, y, @width, @height)

    @crossroad = crossroad.take_by(self) if crossroad && @crossroad != crossroad

    if old_crossroad
      old_crossroad.release_by self

      @crossroad = nil if old_crossroad == @crossroad
    end
  end
end

