
require "drb/drb"
require "rinda/ring"
require "rinda/tuplespace"

DRb.start_service
   
Rinda::TupleSpace.new
Rinda::RingServer.new Rinda::TupleSpace.new

DRb.thread.join
 
