
class TrafficCrossroad < GameObject
  attr_reader :crossroad
  attr_accessor :direction_horizontal, :direction_vertical

  def initialize(crossroad, direction_horizontal = Direction.empty, direction_vertical = Direction.empty)
    @crossroad = crossroad
    @direction_horizontal = direction_horizontal
    @direction_vertical = direction_vertical

    super [ crossroad.x, crossroad.y ]
  end

  def draw(screen)
    unless @direction_horizontal.blank?
      Rubygame::Surface.load("images/crossroad-horizontal.png").blit screen, [ @x, @y ]
    end

    unless @direction_vertical.blank?
      Rubygame::Surface.load("images/crossroad-vertical.png").blit screen, [ @x, @y ]
    end
  end
end

