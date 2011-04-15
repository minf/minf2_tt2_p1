
class Car < GameObject
  def initialize(position, velocity, image)
    @space = Rinda::RingFinger.primary

    @velocity = velocity

    surface = Rubygame::Surface.load image

    @width = surface.width
    @height = surface.height

    super(position, surface)

    Thread.new do
      while true
        Thread.exit if hidden?

        update

        sleep 0.01
      end
    end
  end

  def update
    new_x = @x + @velocity[0]
    new_y = @y + @velocity[1]

    release_crossroad(new_x, new_y)
    take_crossroad(new_x, new_y)

    @x = new_x
    @y = new_y
  end

  def release_crossroad(new_x, new_y)
    if @crossroad && Game.instance.map.crossroads.detect_within(new_x, new_y, @width, @height) != @crossroad
      @space.write [ :crossroad, @crossroad.to_s ]

      @crossroad = nil
    end
  end

  def take_crossroad(new_x, new_y)
    crossroad = Game.instance.map.crossroads.detect_within(new_x, new_y, @width, @height)

    if crossroad && @crossroad != crossroad
      @space.take [ :crossroad, crossroad.to_s ]

      @crossroad = crossroad
    end
  end

  def hidden?
    return @x < 0 || @x > Game.instance.map.width || @y < 0 || @y > Game.instance.map.height
  end
end

