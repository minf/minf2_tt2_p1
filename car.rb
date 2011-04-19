
class Car < GameObject
  def initialize(position, velocity, image)
    @map = Game.instance.map

    @space = Rinda::RingFinger.primary

    @velocity = velocity

    surface = Rubygame::Surface.load image

    @width = surface.width
    @height = surface.height

    super(position, surface)

    Thread.new do
      while true
        update

        sleep 0.01
      end
    end
  end

  def update
    new_x = (@x + @velocity[0]) % Game.instance.map.width
    new_y = (@y + @velocity[1]) % Game.instance.map.height

    manage_crossroads(new_x, new_y)

    @x = new_x
    @y = new_y
  end

  def manage_crossroads(new_x, new_y)
    release_crossroad(new_x, new_y)
    take_crossroad(new_x, new_y)
  end

  def release_crossroad(new_x, new_y)
    if @crossroad && Game.instance.map.crossroads.detect_within(new_x, new_y, @width, @height) != @crossroad
      @space.write [ :traffic, :crossroad, @crossroad.to_s ]

      @crossroad = nil
    end
  end

  def take_crossroad(new_x, new_y)
    crossroad = @map.crossroads.detect_within(new_x, new_y, @width, @height)

    if crossroad && @crossroad != crossroad
      @space.take [ :traffic, :crossroad, crossroad.to_s ]

      @crossroad = crossroad
    end
  end
end

