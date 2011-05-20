
require "trace"
require "space"
require "rubygems"
require "rubygame"
require "game"
require "game_object"
require "map"
require "car"
require "empty_car"
require "crossroad"
require "traffic_crossroad"

# add the crossroads

prototype = Crossroad.new(0, 0, 35, 35) # all crossroads are of equal size

prototype.clone(108, 64).create;  prototype.clone(236, 64).create;  prototype.clone(366, 64).create;  prototype.clone(496, 64).create
prototype.clone(108, 165).create; prototype.clone(236, 165).create; prototype.clone(366, 165).create; prototype.clone(496, 165).create
prototype.clone(108, 272).create; prototype.clone(236, 272).create; prototype.clone(366, 272).create; prototype.clone(496, 272).create
prototype.clone(108, 380).create; prototype.clone(236, 380).create; prototype.clone(366, 380).create; prototype.clone(496, 380).create

# car prototype values

prototypes = [
  # driving from west to east

  [ [ 640, 386 ], [ -1, 0 ], "images/car-east-west.png" ],
  [ [ 640, 278 ], [ -1, 0 ], "images/car-east-west.png" ],
  [ [ 640, 170 ], [ -1, 0 ], "images/car-east-west.png" ],
  [ [ 640, 67 ], [ -1, 0 ], "images/car-east-west.png" ],

  # driving from south to north

  [ [ 517, 480 ], [ 0, -1 ], "images/car-south-north.png" ],
  [ [ 387, 480 ], [ 0, -1 ], "images/car-south-north.png" ],
  [ [ 257, 480 ], [ 0, -1 ], "images/car-south-north.png" ],
  [ [ 127, 480 ], [ 0, -1 ], "images/car-south-north.png" ],
 
  # driving from north to south

  [ [ 503, 0 ], [ 0, 1 ], "images/car-north-south.png" ],
  [ [ 372, 0 ], [ 0, 1 ], "images/car-north-south.png" ],
  [ [ 242, 0 ], [ 0, 1 ], "images/car-north-south.png" ],
  [ [ 112, 0 ], [ 0, 1 ], "images/car-north-south.png" ],
  
  # driving from west to east

  [ [ 0, 401 ], [ 1, 0 ], "images/car-west-east.png" ],
  [ [ 0, 293 ], [ 1, 0 ], "images/car-west-east.png" ],
  [ [ 0, 185 ], [ 1, 0 ], "images/car-west-east.png" ],
  [ [ 0, 82 ], [ 1, 0 ], "images/car-west-east.png" ],
]

# run the came and add cars

game = Game.instance
game.map = Map.new

Thread.new do
  16.times do |i|
    trace { game.add_car Car.new(*prototypes[i % prototypes.size]) }

    sleep 0.5
  end
end

game.run!

