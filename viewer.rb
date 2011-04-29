
require "trace"
require "space"
require "rubygems"
require "rubygame"
require "game"
require "game_object"
require "map"
require "crossroad"
require "empty_car"

game = Game.instance
game.map = Map.new

game.crossroads = []

space = Rinda::RingFinger.primary

Thread.new do 
  trace do
    notifier = space.notify("write", [ :traffic, :crossroad, nil, nil ])

    notifier.each do |_,t|
      crossroad = Marshal.load t[2]
      car = Marshal.load t[3]

      if car.is_a? EmptyCar
        game.crossroads.delete crossroad
      else
        game.crossroads.push crossroad
      end
    end
  end
end

game.run!

