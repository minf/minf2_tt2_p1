
class Map < GameObject
  attr_reader :width, :height

  def initialize
    @image = "images/map.png"

    surface = Rubygame::Surface.load @image

    @width = surface.width
    @height = surface.height

    super [ 0, 0 ]
  end

  def draw(screen)
    Rubygame::Surface.load(@image).blit screen, [ @x, @y ]
  end
end

