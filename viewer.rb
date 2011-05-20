
require "trace"
require "space"
require "rubygems"
require "rubygame"
require "game"
require "game_object"
require "map"
require "crossroad"
require "empty_car"
require "traffic_crossroad"

game = Game.instance
game.map = Map.new

game.traffic_crossroads = []

Crossroad.all.each do |crossroad|
  game.traffic_crossroads.push TrafficCrossroad.new(crossroad)
end

space = Rinda::RingFinger.primary

Thread.new do 
  trace do
    notifier = space.notify("write", [ :traffic, :crossroad, nil, nil, nil ])

    notifier.each do |_,t|
      crossroad = Marshal.load t[2]
      horizontal_cars = t[3]
      vertical_cars = t[4]

      traffic_crossroad = game.traffic_crossroads.detect{ |tc| tc.crossroad == crossroad }

      if traffic_crossroad
        traffic_crossroad.horizontal_cars = horizontal_cars
        traffic_crossroad.vertical_cars = vertical_cars
      end
    end
  end
end

game.run!

