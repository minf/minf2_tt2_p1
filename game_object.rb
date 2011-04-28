
class GameObject
  attr_accessor :x, :y, :width, :height, :surface

  def initialize(position, surface)
    @x = position[0]
    @y = position[1]
    @surface = surface
    @width = surface.width
    @height = surface.height
  end

  def draw(screen)
    @surface.blit screen, [ @x, @y ]
  end
end

