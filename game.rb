
require "singleton"

class Game
  include Singleton

  attr_reader :map

  def initialize
    @sound = Rubygame::Music.load "sound/acceleration.ogg"
    @sound.play :repeats => -1

    @queue = Rubygame::EventQueue.new
    @clock = Rubygame::Clock.new
    @clock.target_framerate = 60

    @cars = []
  end

  def map=(map)
    @map = map

    @screen = Rubygame::Screen.new [ @map.width, @map.height ], 0, [ Rubygame::HWSURFACE, Rubygame::DOUBLEBUF ]
    @screen.title = "Driving Home For Christmas"
  end

  def add_car(car)
    @cars.push car
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
    @map.draw @screen if @map

    # draw cars

    @cars.each do |car| 
      car.draw @screen
    end

    @screen.flip
  end
end

