
class Map < GameObject
  attr_reader :width, :height

  def initialize
    surface = Rubygame::Surface.load "images/map.png"

    @width = surface.width
    @height = surface.height

    super([ 0, 0 ], surface)
  end
end

