
class Car < GameObject
  attr_accessor :velocity
  attr_reader :crossroad

  def initialize(x, y, velocity, image, width, height)
    @velocity = velocity

    @height = width
    @width = height

    surface = Rubygame::Surface.load image

    super(x, y, surface)

    Thread.new do
      while true
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
    if @crossroad && CROSSROADS.detect_within(new_x, new_y, @width, @height) != @crossroad
      SPACE.write [ :crossroad, @crossroad.to_s ]

      @crossroad = nil
    end
  end

  def take_crossroad(new_x, new_y)
    crossroad = CROSSROADS.detect_within(new_x, new_y, @width, @height)

    if crossroad && @crossroad != crossroad
      puts "taking: #{crossroad.to_s}"

      SPACE.take [ :crossroad, crossroad.to_s ]

      @crossroad = crossroad
    end
  end
end

