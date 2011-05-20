
require "trace"
require "space"
require "rubygems"
require "rubygame"
require "game"
require "game_object"
require "map"
require "direction"
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

      traffic_crossroad = game.traffic_crossroads.detect{ |tc| tc.crossroad == crossroad }

      if traffic_crossroad
        traffic_crossroad.direction_horizontal = Marshal.load t[3]
        traffic_crossroad.direction_vertical = Marshal.load t[4]
      end
    end
  end
end

game.run!

