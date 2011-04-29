
class GameObject
  attr_accessor :x, :y, :width, :height, :surface

  def initialize(position)
    @x = position[0]
    @y = position[1]
  end

  def draw(screen)
    @surface.blit screen, [ @x, @y ]
  end
end

