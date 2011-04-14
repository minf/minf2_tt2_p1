
require "drb/drb"
require "rinda/ring"
require "rinda/tuplespace"

DRb.start_service

SPACE = Rinda::RingFinger.primary

require "crossroads"
require "crossroad"

CROSSROADS = Crossroads.new

CROSSROADS.push Crossroad.new(108, 64, 35, 35)
CROSSROADS.push Crossroad.new(236, 64, 35, 35)
CROSSROADS.push Crossroad.new(366, 64, 35, 35)
CROSSROADS.push Crossroad.new(496, 64, 35, 35)

CROSSROADS.push Crossroad.new(108, 165, 35, 35)
CROSSROADS.push Crossroad.new(236, 165, 35, 35)
CROSSROADS.push Crossroad.new(366, 165, 35, 35)
CROSSROADS.push Crossroad.new(496, 165, 35, 35)

CROSSROADS.push Crossroad.new(108, 272, 35, 35)
CROSSROADS.push Crossroad.new(236, 272, 35, 35)
CROSSROADS.push Crossroad.new(366, 272, 35, 35)
CROSSROADS.push Crossroad.new(496, 272, 35, 35)

CROSSROADS.push Crossroad.new(108, 380, 35, 35)
CROSSROADS.push Crossroad.new(236, 380, 35, 35)
CROSSROADS.push Crossroad.new(366, 380, 35, 35)
CROSSROADS.push Crossroad.new(496, 380, 35, 35)

CROSSROADS.each{ |crossroad| SPACE.write [ :crossroad, crossroad.to_s ] }

require "rubygems"
require "rubygame"
require "game"
require "game_object"
require "background"
require "car"

cars = [
  # driving from west to east

  [ 640, 386, [ -1, 0 ], "images/car-east-west.png", 20, 10 ],
  [ 640, 278, [ -1, 0 ], "images/car-east-west.png", 20, 10 ],
  [ 640, 170, [ -1, 0 ], "images/car-east-west.png", 20, 10 ],
  [ 640, 67, [ -1, 0 ], "images/car-east-west.png", 20, 10 ],

  # driving from south to north

  [ 517, 480, [ 0, -1 ], "images/car-south-north.png", 10, 20 ],
  [ 387, 480, [ 0, -1 ], "images/car-south-north.png", 10, 20 ],
  [ 257, 480, [ 0, -1 ], "images/car-south-north.png", 10, 20 ],
  [ 127, 480, [ 0, -1 ], "images/car-south-north.png", 10, 20 ],
 
  # driving from north to south

  [ 503, 0, [ 0, 1 ], "images/car-north-south.png", 10, 20 ],
  [ 372, 0, [ 0, 1 ], "images/car-north-south.png", 10, 20 ],
  [ 242, 0, [ 0, 1 ], "images/car-north-south.png", 10, 20 ],
  [ 112, 0, [ 0, 1 ], "images/car-north-south.png", 10, 20 ],
  
  # driving from west to east

  [ 0, 401, [ 1, 0 ], "images/car-west-east.png", 20, 10 ],
  [ 0, 293, [ 1, 0 ], "images/car-west-east.png", 20, 10 ],
  [ 0, 185, [ 1, 0 ], "images/car-west-east.png", 20, 10 ],
  [ 0, 82, [ 1, 0 ], "images/car-west-east.png", 20, 10 ],
]

g = Game.new

Thread.new do
  count = 0

  while true
    g.add_car Car.new(*cars[count % cars.size])

    count += 1

    sleep 0.5
  end
end

g.run!

