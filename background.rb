
class Background < GameObject
  def initialize
    surface = Rubygame::Surface.load "images/map.png"

    super(0, 0, surface)
  end
end

