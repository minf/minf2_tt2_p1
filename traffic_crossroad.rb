
class TrafficCrossroad < GameObject
  attr_reader :crossroad
  attr_accessor :horizontal_cars, :vertical_cars

  def initialize(crossroad, horizontal_cars = 0, vertical_cars = 0)
    @crossroad = crossroad
    @horizontal_cars = horizontal_cars
    @vertical_cars = vertical_cars

    super [ crossroad.x, crossroad.y ]
  end

  def draw(screen)
    if @horizontal_cars > 0
      Rubygame::Surface.load("images/crossroad-horizontal.png").blit screen, [ @x, @y ]
    elsif @vertical_cars > 0
      Rubygame::Surface.load("images/crossroad-vertical.png").blit screen, [ @x, @y ]
    end
  end
end

