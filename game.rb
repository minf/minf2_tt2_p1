
class Game
  attr_reader :cars

  def initialize
    @screen = Rubygame::Screen.new [ 640, 480 ], 0, [ Rubygame::HWSURFACE, Rubygame::DOUBLEBUF ]

    @screen.title = "The Fast and The Furious"

    @queue = Rubygame::EventQueue.new
    @clock = Rubygame::Clock.new
    @clock.target_framerate = 60

    @background = Background.new

    @cars = []
  end

  def add_car(car)
    cars.push car
  end

  def run!
    loop do
      update

      draw

      @clock.tick
    end
  end

  def update
    @queue.each do |event|
      case event
        when Rubygame::QuitEvent
          Rubygame.quit

          exit
      end
    end
  end

  def draw
    @screen.fill [ 0, 0, 0 ]

    @background.draw @screen

    @cars.each do |car| 
      car.draw @screen
    end

    @screen.flip
  end
end

